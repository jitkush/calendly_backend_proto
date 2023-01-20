require 'rails_helper'

RSpec.describe Agent, :type => :model do
    it "is valid with valid attributes" do
        agent = Agent.new(name:"jeet", email:"tee@gmail.com")
        expect(agent).to be_valid
    end

    it "is not valid without name" do
        agent = Agent.new(name: nil, email:"tee@gmail.com")
        expect(agent).to_not be_valid
    end

    it "is not valid without text" do
        agent = Agent.new(name: 987, email:"tee@gmail.com")
        expect(agent).to_not be_valid
    end

    it "is not valid without email" do
        agent = Agent.new(name:"jeet",email: nil)
        expect(agent).to_not be_valid
    end

    it "is not valid without proper email format" do
        agent = Agent.new(name:"jeet",email: "att@aaa")
        expect(agent).to_not be_valid
    end

    #using an existing email
    it "is not valid if email is not unique" do
         agent = Agent.new(name:"jeet",email: "tanu@gmail.com")
         expect(agent).to_not be_valid
    end

end