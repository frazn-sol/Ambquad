class Client < ActiveRecord::Base
  attr_accessible :company_name, :contact_person, :description, :email, :phone_number, :slogan, :title, :website, :city, :state, :country, :street_number, :address, :logo, :latitude, :longitude
  mount_uploader :logo, LogoUploader
end
