class FetchMovieDetailsJob < ApplicationJob
  require 'net/http'
  queue_as :default

  attr_reader :response

  def perform(api_id)
    @api_key = '6b86fd48'
    api_request = URI("http://www.omdbapi.com/?apikey=#{@api_key}&i=#{CGI.escape(api_id)}")
    incoming = Net::HTTP.get(api_request)
    @response = JSON.parse(incoming)
  end
end

