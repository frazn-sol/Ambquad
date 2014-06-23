class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  protected
   	def after_sign_in_path_for(resource)
   	 	if params[:client].present?
   	 		show_path_path(resource) 
      elsif params[:admin].present? 
        root_path
   	 	end
   	 end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :company_name, :address1, :address2, :city, :state, :country, :logo, :latitude, :longitude) }
    end

    def layout_by_resource
      if devise_controller?
        "users"
      end
    end

end
