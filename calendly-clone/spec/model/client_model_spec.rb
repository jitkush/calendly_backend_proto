require 'rails_helper'

RSpec.describe Client, :type => :model do
    it "is valid with valid attributes" do
        client = Client.new(name:"jeet", email:"tee@gmail.com")
        expect(client).to be_valid
    end

    it "is not valid without name" do
        client = Client.new(name:nil,email:"teej@gmail.cm",contact:nil)
        expect(client).to_not be_valid
    end

    it "is not valid without text" do
        client = Client.new(name:987,email:"teej@gmail.cm",contact:nil)
        expect(client).to_not be_valid
    end

    it "is not valid without email" do
        client = Client.new(name:"jeet",email:nil,contact:nil)
        expect(client).to_not be_valid
    end

    it "is not valid without proper email format" do
        client = Client.new(name:"jeet",email:"teej@gmailcm",contact:nil)
        expect(client).to_not be_valid
    end

    it "is valid without contact" do
        client = Client.new(name:"jeet",email:"teej@gmail.cm",contact:nil)
        expect(client).to be_valid
    end

    it "is not valid without invalid number" do
        client = Client.new(name:"jeet",email:"teej@gmail.cm",contact:"abc")
        expect(client).to_not be_valid
    end

     #using an existing email
    it "is not valid if email is not unique" do
         client = Client.new(name:"jeet",email: "test@test.com")
         expect(client).to_not be_valid
    end
end