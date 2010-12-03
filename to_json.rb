class ToJson
  
  def call env
    @request  = Rack::Request.new env
    
    @response = Rack::Response.new
    @response['Content-Type'] = 'application/json'
  
    # i.e. http://www.earthtools.org/sun/45.505242/-122.595212/3/12/-0800/1
    xml_response = if @request['q']
      parse_xml(@request['q'])
    else
      { :error => "requires parameter 'q' to contain a url that returns an xml response" }
    end
  
    @response.write xml_response.to_json
  
    @response.finish
  end
  
  private
  
    def parse_xml(params) 
      begin
        api_response = Net::HTTP.get_response(URI.parse(@request['q']))
        Crack::XML.parse(api_response.body) unless api_response.value # Raises an error unless status is 2xx
      rescue Exception => e
        @response.status = e.message.to_i # Push the status code
      end
    end
end