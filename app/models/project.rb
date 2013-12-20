class Project < ActiveRecord::Base
  attr_accessible :city, :client, :completion_date, :country, :description, :project_name, :project_status, :project_value, :start_date, :state, :client_id, :images_attributes, :street_number, :address, :latitude, :longitude
  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true
   validates_presence_of :client, :message => "Client can't be blank"
   validates_presence_of :completion_date, :message => "Completion Date can't be blank"
   validates_presence_of :project_name, :message => "Project Name can't be blank"
   validates_presence_of :project_status, :message => "Project Status can't be blank"
   validates_presence_of :start_date, :message => "Start Date can't be blank"
   validates_presence_of :latitude, :message => "Please select a valid location from suggestions"
   validates_presence_of :longitude, :message => "Please select a valid location from suggestions"
end
