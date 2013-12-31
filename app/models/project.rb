class Project < ActiveRecord::Base
  attr_accessible :city, :client_name, :completion_date, :country, :description, :project_name, :project_status, :project_value, :start_date, :state, :client_id, :images_attributes, :address1, :address2, :latitude, :longitude
  has_many :images,   :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  belongs_to :client
  validates  :client, :presence => true  
  validates_presence_of :client_name, :message => "Client can't be blank"
  validates_presence_of :project_name, :message => "Project Name can't be blank"
  validates_presence_of :project_status, :message => "Project Status can't be blank"
  validates_presence_of :start_date, :message => "Start Date can't be blank"
  # validates_presence_of :completion_date, :message => "Completion Date can't be blank"
  validates_presence_of :address1, :message => "Address can't be blank"   
  validates_presence_of :city, :message => "City can't be blank"   
  validates_presence_of :state, :message => "State can't be blank"   
  validates_presence_of :country, :message => "Country can't be blank"   
  validates_presence_of :client_name, :message => "Client name can't be blank"   
  validate :check_lat_long
  def check_lat_long
    if (self.latitude == nil && self.longitude == nil)
      errors.add(:base, "Please select a valid location from suggestions")
    elsif (self.latitude == nil || self.longitude == nil)  
      errors.add(:base, "Please select a valid location from suggestions")
    end  
  end
  
end

