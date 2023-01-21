class Meeting < ApplicationRecord
  class AgentNotAvailableError < StandardError
    attr_reader :date, :time

    def initialize(date, time)
      @date = date
      @time = time
    end

    def message
      "Agent was not available for #{date} and #{time}"
    end
  end

  belongs_to :agent, class_name: 'Agent'
  belongs_to :client, class_name: 'Client'

  date_reg = /(20[0-9][0-9]|30[0-1][0-9])-(0[0-9]|1[0-2])-(0[0-9]|1[0-9]|2[0-9]|3[0-1])/
  time_reg = /(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)/

  # validating meeting_id from frontend, need to be a string,cannot be null,no duplicate value
  validates :meeting_id,
            presence: { message: 'Meeting_id is empty' },
            uniqueness: { message: 'Received duplicate Meeting_id' },
            numericality: false

  # agent id cannot be null, needs to be a number
  validates :agent_id,
            presence: { message: 'Agent_id is empty' },
            numericality: { message: 'Agent_Id should be a number' }

  # client id cannot be null, needs to be a number
  validates :client_id,
            presence: { message: 'Client_id is empty' },
            numericality: { message: 'Agent_id should be a number' }
  # date cannot be null, should adhere to YYY-MM-DD format
  validates :date,
            presence: { message: 'date is empty' },
            format: { with: date_reg, message: 'Invalid date' }

  # time cannot be null, shold asdhere to HH:MM:SS
  validates :time,
            presence: { message: 'time is empty' },
            format: { with: time_reg, message: 'Invalid time' }

  validate :agent_availability

  private

  def agent_availability(date, time)
    raise AgentNotAvailableError.new(date, time) unless agent.available?(date, time)
  end
end
