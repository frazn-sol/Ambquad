class ClientsController < ApplicationController
  before_filter :check_action, :only => [:index, :edit, :destroy, :create, :update]

  def index
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  # Shows all the client related projects and info
  def show        
    @client = Client.find(params[:id])
    @project = Project.new
    @project.images.build
    @project.client_id = @client.id
    @projects = @client.projects.all
    @images = {}
    @projects.each_with_index do |project,i|
      @images[i] = project.images.first.image.url(:thumb).to_s if project.images.present? 
    end
    respond_to do |format|
      format.html {render :layout => "client"}# show.html.erb
      format.json { render json: @hash }
    end
  end

  #Shows the error page in case of wrong action accessed
  def error
    render :layout => false
  end

  private
  def check_action
    if params[:action]!="show"
      redirect_to error_clients_path
    end
  end
end
