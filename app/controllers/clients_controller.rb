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
    if current_client.present?
      @client = current_client
    else 
      @client = Client.friendly.find(params[:id])
    end
    @project = Project.new
    @project.images.build
    @project.client_id = @client.id
    @projects = @client.projects.all
    @images = {}
    @projects.each_with_index do |project,i|
      @images[i] = project.images.first.image.url(:thumb).to_s if project.images.present? 
    end
    #Entry in visit
    user_agent = UserAgent.parse(request.user_agent)
    browser    = user_agent.browser
    api_type   = @client.api_type_id
    client_id  = @client.id
    Visit.create(:browser => browser, :api_type_id => api_type, :client_id => client_id)

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
