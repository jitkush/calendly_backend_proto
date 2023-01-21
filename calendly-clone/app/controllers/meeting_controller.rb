require 'date'

# could not figure out how to maintain seperate file for the following validating agent,client,availability
class MeetingController < ApplicationController
  before_action :find_agent
  before_action :find_client

  # adding meeting after validating agent,client, agent availability
  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
      render json: @meeting
    else
      render json: @meeting.errors
    end
  end

  # getting all the meeting
  def index
    @meeting = Meeting.all

    render json: { status: 'success', message: 'all meeting list', data: @meeting }
  end

  # get all upcoming meeting for a agent
  def view_agent_meeting
    date = Date.today
    @agent = Meeting.where('agent_id = :id AND date >= :dateToday', { id: params[:id], dateToday: date })
    render json: { data: @agent }
  end

  # get all upcoming meeting for a client
  def view_client_meeting
    date = Date.today
    @client = Meeting.where('client_id = :id AND date >= :dateToday', { id: params[:id], dateToday: date })
    render json: { data: @client }
  end

  private

  # defining params to add client
  def client_param
    params.permit(:name, :email, :contact)
  end

  # assuming client can create an account with comapny and then book meeting,
  # or it is scheduling another meeting we are checking if the client is available in database
  # or it can directly book meeting; so for reporting/follow-up scenerios we are creating a cliet record
  # before creating a meeting
  def find_client
    @client = Client.find_by(email: params[:email])
  end

  def find_agent
    @agent = Agent.find(params[:agent_id])
  end

  # defining params to add meeting
  def meeting_params
    params.permit(:meeting_id, :agent_id, :client_id, :date, :time)
  end

  # checking if agent is availabe for the time client is bookking meeting
  def validate_agent_avalibility
    @agent_available = Meeting.where('agent_id = :id AND date = :date and time = :time',
                                     { id: params[:agent_id], date: params[:date], time: params[:time] })

    if @agent_available.blank?
      { status: true, data: @agent_available }
    else
      { status: false, data: @agent_available }
    end
  end
end
