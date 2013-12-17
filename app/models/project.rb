class Project < ActiveRecord::Base
  attr_accessible :city, :client, :completion_date, :country, :description, :project_name, :project_status, :project_value, :start_date, :state, :client_id, :images_attributes
  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images
end
