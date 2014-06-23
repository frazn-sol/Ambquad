class Visit < ActiveRecord::Base
  belongs_to :api_type
  belongs_to :clients
  attr_accessible :api_type_id, :client_id, :browser
end
