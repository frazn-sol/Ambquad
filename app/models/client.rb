class Client < ActiveRecord::Base

  attr_accessible :company_name, :contact_person, :description, :email, :phone_number, :slogan, :title, :website, :city, :state, :country, :address1, :address2, :logo, :latitude, :longitude, :template, :permalink
  mount_uploader :logo, LogoUploader

  has_many :projects, :foreign_key => 'client_id', :dependent => :destroy

  extend FriendlyId
  friendly_id :custom_link, use: [:slugged, :history]
  
  validates_presence_of :company_name, :message => "Company Name can't be blank"
  # validates_presence_of :contact_person, :message => "Contact Person can't be blank"
  # validates_presence_of :email, :message => "Email can't be blank"
  # validates_presence_of :phone_number, :message => "Phone Number can't be blank"
  # validates_presence_of :title, :message => "Title can't be blank"   
  # validates_presence_of :slogan, :message => "Slogan can't be blank"   
  # validates_presence_of :website, :message => "Website can't be blank"    
  validates_uniqueness_of :permalink, :message => "Permalink has already been taken" 
  validates_presence_of :city, :message => "City can't be blank"   
  validates_presence_of :country, :message => "Country can't be blank"   
  validates_presence_of :logo, :message => "Logo can't be blank"
  validate :check_lat_long
  validate :logo_size  
  
  def check_lat_long
    if (self.latitude == nil && self.longitude == nil)
      errors.add(:base, "Please select a valid location from suggestions")
    elsif (self.latitude == nil || self.longitude == nil)  
      errors.add(:base, "Please select a valid location from suggestions")
    end  
  end

  def logo_size
    if logo.file.size.to_f/(1000*1000) > 2.0
      errors.add(:file, "You cannot upload a file greater than 2 MB")
    end
  end

  def custom_link
    if self.permalink.blank?
      self.company_name
    else
      self.permalink
    end
  end

end

