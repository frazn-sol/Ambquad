class Client < ActiveRecord::Base
  attr_accessible :company_name, :contact_person, :description, :email, :phone_number, :slogan, :title, :website, :city, :state, :country, :street_number, :address, :logo, :latitude, :longitude
  mount_uploader :logo, LogoUploader

  extend FriendlyId
  friendly_id :company_name, use: [:slugged, :history]
   validates_presence_of :company_name, :message => "Company Name can't be blank"
   validates_presence_of :contact_person, :message => "Contact Person can't be blank"
   validates_presence_of :email, :message => "Email can't be blank"
   validates_presence_of :phone_number, :message => "Phone Number can't be blank"
   validates_presence_of :title, :message => "Title can't be blank"   
   validate :check_lat_long
  
  def check_lat_long
    if (self.latitude == nil && self.longitude == nil)
      errors.add(:base, "Please select a valid location from suggestions")
    elsif (self.latitude == nil || self.longitude == nil)  
      errors.add(:base, "Please select a valid location from suggestions")
    end  
  end
end

