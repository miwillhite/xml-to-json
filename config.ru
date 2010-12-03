require 'net/http'
require 'crack'
require 'json'
require './xml_to_json.rb'

use Rack::ShowExceptions

run XmlToJson.new
