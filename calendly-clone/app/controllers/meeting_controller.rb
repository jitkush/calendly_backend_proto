#could not figure out how to maintain seperate file for the following validating agent,client,availability 

class MeetingController < ApplicationController
    require 'date'
    
    #assuming calender invite link is share by the agent;
    #we will check if the agent exists in the database before sceduling meeting
    def find_agent
        @agent = Agent.find_by(id: params[:agent_id])

        unless @agent
           return {status: false}
        else
            return {status: true}
        end
    end

    #defining params to add client
    def client_param
        params.permit(:name, :email, :contact)
    end

    #assuming client can create an account with comapny and then book meeting,
    #or it is scheduling another meeting we are checking if the client is available in database
    #or it can directly book meeting; so for reporting/follow-up scenerios we are creating a cliet record
    #before creating a meeting
    def find_client
    @client = Client.find_by(email: params[:email])

        unless @client
            @client = Client.new(client_param)
                if @client.save
                    params[:client_id] =  @client[:id];
                    return {status: true}
                else
                    return {status: false, error: @client.errors}
                end
            else
                params[:client_id] = @client[:id];
                return {status:true}
        end
    end

    #defining params to add meeting
    def meeting_params
        params.permit(:meeting_id,:agent_id,:client_id, :date, :time)
    end

    #checking if agent is availabe for the time client is bookking meeting 
    def validate_agent_avalibility
        @agent_available = Meeting.where("agent_id = :id AND date = :date and time = :time",{id:params[:agent_id], date: params[:date], time: params[:time]})

        unless @agent_available.blank?
            return {status:false, data: @agent_available}
        else
            return {status:true, data: @agent_available}
        end
    end
    
    #adding meeting after validating agent,client, agent availability 
    def add_meeting
        @valid_agent = find_agent
        @valid_client = find_client
        @validate_date_time = validate_agent_avalibility

      
        if(!@valid_agent[:status])
            render json: {status: "Agent Error", message: "Agent not found"}
            return
        end

        if(!@validate_date_time[:status])
            render json: {status: "Agent unavailable", message:"Please select another time/date"}
            return
        end

        if(!@valid_client[:status])
            render json: {status: "Client Error", message: "Something is wrong with client data", data:@valid_client[:error]}
            return
        end


            @meeting = Meeting.new(meeting_params)
            if @meeting.save
                render json: {status: "Success", message:"Meeting creation success", data:@meeting}
            else
                render json: {status: "Failed", message:"Meeting creation failed", data:@meeting.errors}
            end

   
    end

    #getting all the meeting
    def all_meeting
        @meeting = Meeting.all

        render json:{status:"success", message:"all meeting list", data:@meeting}
    end

    #get all upcoming meeting for a agent
    def view_agent_meeting
        date = Date.today
            @agent = Meeting.where("agent_id = :id AND date >= :dateToday",{id:params[:id], dateToday: date})
            render json: {data:@agent}
    end

    #get all upcoming meeting for a client 
    def view_client_meeting
        date = Date.today
        @client = Meeting.where("client_id = :id AND date >= :dateToday",{id:params[:id],dateToday: date})
        render json: {data:@client}
    end
end
