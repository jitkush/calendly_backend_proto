require 'rails_helper'

RSpec.describe Meeting, :type => :model do
    it "is valid with valid attributes" do
        meeting = Meeting.new( "meeting_id": "s1o1234","agent_id": 3,"client_id": 50,"date": "2023-02-01","time": "10:08:32")
        expect(meeting).to be_valid
    end

    it "is not valid without meetimg id" do
        meeting = Meeting.new("meeting_id": nil,"agent_id": 3,"client_id": 50,"date": "2023-02-01","time": "10:08:32")
        expect(meeting).to_not be_valid
    end

    it "is not valid without meeting id is not string" do
         meeting = Meeting.new("meeting_id": 123,"agent_id": 3,"client_id": 50,"date": "2023-02-01","time": "210:08:32")
         expect(meeting).to_not be_valid
    end

    it "is not valid without agent id" do
        meeting = Meeting.new("meeting_id": "se33o1234","agent_id": nil,"client_id": 50,"date": "2023-02-01","time": "10:08:32")
        expect(meeting).to_not be_valid
    end

     it "is not valid agent id is not integer" do
        meeting = Meeting.new("meeting_id": "s2e3o1234","agent_id": "abc","client_id": 50,"date": "2023-02-01","time": "10:08:32")
        expect(meeting).to_not be_valid
    end

     it "is not valid without client id" do
        meeting = Meeting.new("meeting_id": "1se3o1234","agent_id": 3,"client_id": nil,"date": "2023-02-01","time": "210:08:32")
        expect(meeting).to_not be_valid
     end

     it "is not valid if client id is not integer" do
        meeting = Meeting.new("meeting_id": "s3e7o1234","agent_id": 3,"client_id": "abc","date": "2023-02-01","time": "10:08:32")
        expect(meeting).to_not be_valid
     end

     it "is not valid without date" do
        meeting = Meeting.new("meeting_id": "s9e7o1234","agent_id": 3,"client_id": 33,"date":nil,"time": "10:08:32")
        expect(meeting).to_not be_valid
     end

     it "is not valid without date format" do
        meeting = Meeting.new("meeting_id": "11se2o1234","agent_id": 3,"client_id": 33,"date": "2023-02","time": "10:08:32")
        expect(meeting).to_not be_valid
     end

     it "is not valid without time" do
        meeting = Meeting.new("meeting_id": "1s77eo11234","agent_id": 3,"client_id": 33,"date": "2023-02-01","time": nil)
        expect(meeting).to_not be_valid
     end

     it "is not valid without time format" do
        meeting = Meeting.new("meeting_id": "s66e22o1234","agent_id": 3,"client_id": 33,"date": "2023-02-01","time": "10:08")
        expect(meeting).to_not be_valid
     end

     #using an existing meeting_id 
     it "is not valid if meeting_id is not unique" do
      meeting = Meeting.new("meeting_id": "seo1234","agent_id": 3,"client_id": 33,"date": "2023-02-01","time": "10:08:32")
      expect(meeting).to_not be_valid
     end
    
end