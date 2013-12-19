class ShortenedLinkController < ApplicationController
	def translate
    sl = ShortenedLink.find_by_unique_key(params[:unique_key])
 
    if sl
      # don't want to wait for the increment to happen, make it snappy!
      Thread.new do
        # this is the place to enhance the metrics captured
        # for the system. You could log the request origin
        # browser type, ip address etc.
        sl.increment!(:use_count)
      end
      # do a 301 redirect to the destination url
      head :moved_permanently, :location => sl.url
    else
      # if we don't find the shortened link, redirect to the root
      head :moved_permanently, :location => root_url
    end
  	end

end
