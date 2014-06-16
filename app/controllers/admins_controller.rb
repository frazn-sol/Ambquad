class AdminsController < ApplicationController
  # before_filter :authenticate_admin!, :except => [:forgot_password, :reset_password]
 
	
  # Shows the landing/main page for admin
  def index
    if current_admin.present?
      @clients = Client.all
      @client = Client.new
      respond_to do |format|
    		format.html # index.html.erb
    		format.json { render json: @clients }
    	end
    else
      redirect_to new_admin_session_path and return
    end  
  end


  def show
    redirect_to error_admins_path
  end

  # Render new clients view
  def new
    if current_admin.present?
      @clients = Client.all
      @client = Client.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @client }
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end

  # Renders the esit client view
  def edit
    if current_admin.present?
      @client = Client.friendly.find(params[:id])
    else
      redirect_to new_admin_session_path and return
    end
  end

  # POST /clients
  # POST /clients.json
  # Create Client
  def create_client
    if current_admin.present?
      @client = Client.new(params[:client])
      respond_to do |format|
        if @client.save
          flash[:notice] = "Client has been successfully added!"
          format.html { redirect_to admins_path }
          format.json { render json: @client, status: :created, location: @client }
        else
          format.html { render action: "new" }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end

  # PUT /clients/1
  # PUT /clients/1.json
  # Update Client
  def update_client
    if current_admin.present?
      @client = Client.friendly.find(params[:id])
      respond_to do |format|
        if @client.update_attributes(params[:client])
          format.html { redirect_to admins_path, notice: 'Client was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  # Delete client 
  def destroy
    if current_admin.present?
      @client = Client.friendly.find(params[:id])
      @client.destroy
      respond_to do |format|
        format.html { redirect_to admins_url }
        format.json { head :no_content }
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end

  # Render create new project view
  def new_project
    if current_admin.present? || current_client.present?
      @project = Project.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @project }
      end
    else
      redirect_to new_admin_session_path and return
    end
  end

  # Creates new projects
  def create_project
    if current_admin.present? || current_client.present?
      @project = Project.new(params[:project])
      client   = @project.client
      respond_to do |format|
        if @project.save
          flash[:notice] = "Project has been successfully added!"
          redirect_to client_path(client) and return
        else
          flash[:notice] = "Project has not been successfully added!"
          redirect_to client_path(client) and return
        end
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end

  #Checks for the server validations on project form
  def validate_project
    if current_admin.present? || current_client.present?
      params[:project][:images_attributes] = {}
      @project = Project.new(params[:project])
      client   = @project.client
      @json = Hash.new
      respond_to do |format|
        if @project.valid?
          @json["result"] = "true"
          format.json { render json: @json }
        else
          @json["result"] = "false"
          @json["errors"] = @project.errors
          format.json { render json: @json }
        end
      end
    else
      @json["result"] = "false"
      @json["errors"] = "You need to sign in first"
      format.json { render json: @json }
    end  
  end

  #Renders edit project view
  def edit_project
    if current_admin.present? || current_client.present?
      @project = Project.find(params[:id])
    else
      redirect_to new_admin_session_path and return
    end  
  end

  #Updates the project
  def update_project  
    if current_admin.present? || current_client.present?
      @project = Project.find(params[:id])
      client   = @project.client
      respond_to do |format|
        if @project.update_attributes(params[:project])
          format.html { redirect_to client_path(client), notice: 'Project was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit_project" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end


  # Delete the project
  def delete_project
    if current_admin.present? || current_client.present?
      @project = Project.find(params[:id])
      client = @project.client
      @project.destroy
      respond_to do |format|
        format.html { redirect_to client_path(client) }
        format.json { head :no_content }
      end
    else
      redirect_to new_admin_session_path and return
    end  
  end

  # Render view for reseting the password
  def forgot_password
    @admin = Admin.find(1)
  end

  # Resets the password for the admin
  def reset_password
    @admin = Admin.find_by_email(params[:admin][:email])
    if @admin
      account_update_params = params[:admin]
      # required for settings form to submit when password is left blank
      if account_update_params[:password].blank?
        flash[:notice] = "Email can't be empty"
        redirect_to forgot_password_admins_path and return
      end
      if account_update_params[:password_confirmation].blank?
        flash[:notice] = "Email confirmation can't be empty"
        redirect_to forgot_password_admins_path and return
      elsif account_update_params[:password_confirmation] != account_update_params[:password] 
        flash[:notice] = "Password you entered does not match"
        redirect_to forgot_password_admins_path and return
      end
      account_update_params.delete("password_confirmation")
      if @admin.update_attributes(account_update_params)
        flash[:notice] = "Password has been successfully changed"
        # Sign in the user bypassing validation in case his password changed
        redirect_to root_url
      else
        flash[:notice] = @admin.errors.full_messages.join("&")
        render "forgot_password"
      end
    else
      flash[:notice] = "Email you entered does not exist"
      redirect_to forgot_password_admins_path and return
    end
  end

  def code
    if current_admin.present?
      @code = InviteCode.new
    else
      redirect_to new_admin_session_path and return
    end  
  end

  def save_code
    @code = InviteCode.new(params[:invite_code])
    respond_to do |format|
      if @code.save
        format.html { redirect_to root_url, notice: 'Code successfully created' }
        format.json { head :no_content }
      else
        format.html { render action: "code" }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_code
    if current_admin.present?
      @code = InviteCode.find(params[:id])
      @code.destroy
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
      end  
    else
      redirect_to new_admin_session_path and return
    end  
  end


  def error
    render :layout => false
  end
end
