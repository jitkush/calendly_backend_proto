require 'rails_helper'

#testing the API for Client
RSpec.describe 'Client API', type: :request do
    describe 'GET /client/list' do
        it 'returns all client' do
         FactoryBot.create(:client, name:"jeet", email:"jeet@mail.com", contact:987766541)
         FactoryBot.create(:client, name:"josua", email:"josua@gmail.com", contact:987766540)
         FactoryBot.create(:client, name:"jeet", email:"jeet@jeet.com", contact:987766240)

         get '/client/list'

         expect(response).to have_http_status(:success)
         expect(JSON.parse(response.body).size).to eq(3)
        end
   end

   #set the :id value to a value that exists if the validation fails
   #use /client/list to get client list
   describe 'GET /client/show/:id' do
    it 'return client matching the id' do
        get '/client/show/1'
        expect(response).to have_http_status(:success)
    end
   end

   describe 'POST /client/add' do
    it 'create a new client' do
        post '/client/add', params: { client: {name:"jeet", email:"jeet@mm.com", contact:88399993}}
        expect(response).to have_http_status(:success)
    end
   end


   #set the :id value to a value that exists if the validation fails
   #use /client/list to get client list
   describe 'PATCH /client/update/:id' do
    it 'updates a existing agent' do
        patch '/client/update/25', params: { client: {name:"jimmy"}}
        expect(response).to have_http_status(:success)
    end
   end

   #set the :id value to a value that exists if the validation fails
   #use /client/list to get client list
   describe 'DELETE /agent/remove/:id' do 
    it 'delete a user' do
        delete '/client/remove/24'
        expect(response).to have_http_status(302)
    end
   end
end