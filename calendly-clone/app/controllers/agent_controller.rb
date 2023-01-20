class AgentController < ApplicationController
    
    #get all agent details
    def list
        @agents =Agent.all
        render json: {status: 'success', message: 'List of agents', data:@agents}
    end

    #get agent details by id
    def show
        @agent = Agent.find(params[:id])
        render json: {status: 'success', message: 'List of agents', data:@agent}
    end

    #add an agent
    def add
        @agent =Agent.new(agent_param)
        if @agent.save
            redirect_to :action => "list"
        else
             render json: {status: 'failed', message: 'failed to add agent', data:@agent.errors}
        end
    end
    
    #params to add agent details
    def agent_param
        params.permit(:name, :email)
    end

    #params to update agent; getting error; need to figure out
    def agent_params
        params.require(:agent).permit(:name, :email)
    end
    
    #updating a agent record
    def update
        @agent = Agent.find(params[:id])
        
        if @agent.update(agent_params)
           render json: {status: 'success', message: 'update successfull', data: @agent}
        else
            render json: {status: 'failed', message: 'filed to add agent', data: @agent.errors}
        end
    end

    #removing an agent
    def remove_agent
        @agent = Agent.find(params[:id])
        if @agent.destroy
            redirect_to :action=> "list"
        else
            render json: {status:"failed", message:"User not found"}
        end
    end

end