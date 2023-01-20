require 'rails_helper'

#testing the Meeting for Agent

RSpec.describe 'Meeting API', type: :request do
    describe 'GET /meeting/all' do
        it 'returns all meeting' do
         #not using FactoryBot because we have client id generation in the meeting controller.   
         get '/meeting/all'
         expect(response).to have_http_status(:success)
         expect(JSON.parse(response.body).size).to eq(3)
        end
   end

   describe 'POST /meeting/add' do
    it 'will add a meeting' do

        post '/meeting/add', params:{ "meeting_id":"s1n1034","agent_id":2,"name":"client2","email":"test1@test.com","contact":9852948,"date":"2023-02-01","time":"12:08:32"}
        expect(response).to have_http_status(:success)
    end
   end

   #if test fails try changin the :id, get agent_id from /meeting/all 
   describe 'GET /meeting/agent/upcoming/:id' do
    it 'will return upcming meeting of an agent' do

        get '/meeting/agent/upcoming/2'
        expect(response).to have_http_status(:success)
    end
   end

   #if test fails try changin the :id, get agent_id from /meeting/all 
   describe 'GET /meeting/client/upcoming/:id' do
    it 'will return upcming meeting of an agent' do

        get '/meeting/client/upcoming/50'
        expect(response).to have_http_status(:success)
    end
   end

end