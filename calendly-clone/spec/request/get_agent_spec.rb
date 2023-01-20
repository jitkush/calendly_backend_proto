require 'rails_helper'

#testing the API for Agent

RSpec.describe 'Agents API', type: :request do
    describe 'GET /agent/list' do
        it 'returns all agents' do
         FactoryBot.create(:agent, name:"jeet", email:"jeet@mail.com")
         FactoryBot.create(:agent, name:"josua", email:"josua@gmail.com")
         FactoryBot.create(:agent, name:"jeet", email:"jeet@jeet.com")

         get '/agent/list'

         expect(response).to have_http_status(:success)
         expect(JSON.parse(response.body).size).to eq(3)
        end
   end

   #set the :id value to a value that exists if the validation fails
   #use /agent/list to get agent list
   describe 'GET /agents/show/:id' do
    it 'return agent matching the id' do
        get '/agent/show/1'
        expect(response).to have_http_status(:success)
    end
   end

   describe 'POST /agent/add' do
    it 'create a new agent' do
        post '/agent/add', params: { agent: {name:"jeet", email:"jeet@mm.com"}}
        expect(response).to have_http_status(:success)
    end
   end

   #set the :id value to a value that exists if the validation fails
   #use /agent/list to get agent list
   describe 'PATCH /agent/update/:id' do
    it 'updates a existing agent' do
        patch '/agent/update/1', params: { agent: {name:"jimmy"}}
        expect(response).to have_http_status(:success)
    end
   end

   #set the :id value to a value that exists if the validation fails
   #use /agent/list to get agent list
   describe 'DELETE /agent/remove/:id' do 
    it 'delete a user' do
        delete '/agent/remove/2'
        expect(response).to have_http_status(302)
    end
   end
end