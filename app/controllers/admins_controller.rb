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
    @clients = Client.all
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create_client
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
end
