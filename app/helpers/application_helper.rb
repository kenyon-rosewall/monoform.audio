require 'net/http'
require 'net/https'

module ApplicationHelper
	def post_data(url, payload)
		uri = URI.parse(url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true
		req = Net::HTTP::Post.new(uri.path)
		
		req.set_form_data(payload)
		res = https.request(req)
		JSON.parse(res.body)
	end
end
