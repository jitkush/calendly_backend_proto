class ClientController < ApplicationController

    #get all client
    def list
        @client =Client.all
        render json: {status: 'ok', message: 'List of Clients', data:@client}
    end

    #get client by id
    def show
        @Client = Client.find(params[:id])
        render json: {status: 'ok', message: 'List of Clients', data:@Client}
    end

    #add a client
    def add
        @Client =Client.new(client_param)
        if @Client.save
            redirect_to :action => "list"
        else
             render json: {status: 'failed', message: 'filed to add Client', data:@Client.errors}
        end
    end

    #params for adding client
    def client_param
        params.permit(:name, :email, :contact)
    end

    #parmas for updating client; was getting error; so had to create seperate method
    #need to check
    def client_params
        params.require(:client).permit(:name, :email, :contact)
    end
    
    #updating a client details
    def update
        @Client = Client.find(params[:id])
        
        if @Client.update(client_params)
           render json: {status: 'success', message: 'update successfull', data: @Client}
        else
            render json: {status: 'failed', message: 'filed to add Client', data: @Client.errors}
       end
    end

    #deleting client details
    def remove_client
        Client.find(params[:id]).destroy
        redirect_to :action=> "list"
    end
end
