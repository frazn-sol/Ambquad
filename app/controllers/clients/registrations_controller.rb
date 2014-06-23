class Clients::RegistrationsController < Devise::RegistrationsController
	def create
		@code = params[:client][:description]
		params[:client].delete :description
		@found = InviteCode.where(:code => @code).last
		if @found.present?
			if @found.end_date.to_date < Date.today.to_date
 		    	redirect_to new_client_registration_path, :notice => "Your code has expired" 
      		elsif @found.end_date.to_s >= Date.today.to_s
      			@client = Client.new(params[:client])
      			if @client.save
      				redirect_to new_client_registration_path, :notice => "Email has been sent to you for confirmation"
				end
			end
		else
			redirect_to new_client_registration_path, :notice => "Code does not exist"	
		end
	end
end


# class Clients::RegistrationsController < Devise::RegistrationsController
# 	def create
# 		@code = params[:client][:description]
# 		params[:client].delete :description
# 		@invite_code = InviteCode.where(:code => @code).first
# 		if @invite_code.present?
# 			if @invite_code.end_date.to_s < Date.today.to_s
#  		    	redirect_to new_client_registration_path, :notice => "Invitation code has been expired. Please request for new Invitation Code." 
#       		else @invite_code.end_date.to_s >= Date.today.to_s
#       			@client = Client.new(params[:client])
#       			@invite_code.usage += 1; 
#       			@client.invite_code_id = @invite_code.id
# 					binding.pry
#       			if @client.save
# 	      			@invite_code.save
# 					binding.pry
#       				sign_in(:client, @client)
#       				redirect_to client_path(@client) 
# 				end
# 			end
# 		else
# 			redirect_to new_client_registration_path, :notice => "You have entered wrong Invitation Code. Please enter correct code and retry."	
# 		end
# 	end
# end
