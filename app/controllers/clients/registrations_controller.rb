class Clients::RegistrationsController < Devise::RegistrationsController
	def create
		@code = params[:client][:description]
		params[:client].delete :description
		@found = InviteCode.where(:code => @code).last
		if  @found.present?
			if @found.end_date.to_s < Date.today.to_s
 		    	redirect_to new_client_registration_path, :notice => "Your code has expired" 
      		else @found.end_date.to_s >= Date.today.to_s
      			@client = Client.new(params[:client])
      			@client.invite_code_id = @found.id
      			if @client.save
      				sign_in(:client, @client)
      				redirect_to client_path(@client) 
				end
			end
		else
			redirect_to new_client_registration_path, :notice => "Code does not exist"	
		end
	end
end
