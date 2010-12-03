class ToJson
  
  def call env
    request  = Rack::Request.new env
    response = Rack::Response.new
    response['Content-Type'] = 'application/json'
  
    # http://www.earthtools.org/sun/45.505242/-122.595212/3/12/-0800/1
    xml_response = if request['q']
      d = Crack::XML.parse(Net::HTTP.get_response(URI.parse(request['q'])).body)
    else
      # Give an error or something useful
    end
  
    response.write xml_response.to_json
  
    response.finish
  end
end