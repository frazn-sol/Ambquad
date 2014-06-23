class InviteCode < ActiveRecord::Base
  has_many :clients
  attr_accessible :code, :usage, :start_date, :end_date
  validates_uniqueness_of :code, :message => "Code must be unique"
end
