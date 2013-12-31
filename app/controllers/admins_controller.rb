class AdminsController < ApplicationController
	before_filter :authenticate_admin!
	
	def index
		@clients = Client.all
    @client = Client.new
		respond_to do |format|
  		format.html # index.html.erb
  		format.json { render json: @clients }
  	end
  end

  def show
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  def new
    @clients = Client.all
    @client = Client.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create_client
    @client = Client.new(params[:client])
    binding.pry
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
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update_client
    @client = Client.find(params[:id])
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to admins_path, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end

  def new_project
    @project = Project.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def create_project
    binding.pry
    @project = Project.new(params[:project])
    binding.pry
    client   = @project.client
    respond_to do |format|
      if @project.save
        flash[:notice] = "Project has been successfully added!"
        format.html { redirect_to client_path(client) }
        format.json { render json: @project, status: :created, location: client_path(client) }
      else
        format.html { redirect_to client_path(client) }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_project
    @project = Project.find(params[:id])
  end

  def update_project
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to admins_path, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_project" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def view_project
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def delete_project
    @project = Project.find(params[:id])
    client = @project.client
    @project.destroy
    respond_to do |format|
      format.html { redirect_to client_path(client) }
      format.json { head :no_content }
    end
  end

end
