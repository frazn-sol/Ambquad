class ApiType < ActiveRecord::Base
    has_many :clients
    has_many :visits
	attr_accessible :name
end
