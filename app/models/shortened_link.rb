class ShortenedLink < ActiveRecord::Base
  # attr_accessible :title, :body
  
  include ActionController::UrlWriter
 
  belongs_to :client # allows the shortened link to be associated with a client
 
  # this is best placed in your env files so you can have localhost for dev
  HOST_NAME = 'ambquad.com'
  UNIQUE_KEY_LENGTH = 5
  # it can be useful to easily know how long the shortened link will be
  # the start of the link for dealush is http://dealush.com/s/ (21 chars)
  # change the number as needed for your site
  LENGTH = 5 + UNIQUE_KEY_LENGTH
 
  # generate a shortened link from a url
  # link to a client if one specified
  def self.generate(orig_url, client=nil)
    # don't want to generate the link if it has already been generated
    # so check the datastore
    uid = client.nil? ? nil : client.id
    sl = ShortenedLink.find_by_url_and_client_id(orig_url, uid)
    return sl.shortened_url if sl
 
    # generate a unique key for the link
    begin
      # has about 50 million possible combos
      unique_key = self.generate_random_string(UNIQUE_KEY_LENGTH)
    end while ShortenedLink.find_by_unique_key unique_key
 
    # create the shortened link, storing it
    sl = ShortenedLink.create(:url => orig_url, :unique_key => unique_key, :client => client)
 
    # return the url
    return sl.shortened_url
  end
 
  # create the shortened url from the unique key
  def shortened_url
    # use the url writer to generate the url
    return link_translate_url(:unique_key => self.unique_key, :host => HOST_NAME)
  end
 
  # generate a random string
  def self.generate_random_string(size = 5)
    # not doing uppercase as url is case insensitive
    charset = ('a'..'z').to_a + (0..9).to_a
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

end
