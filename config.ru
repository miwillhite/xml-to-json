require 'net/http'
require 'crack'
require 'json'
require './to_json.rb'

use Rack::ShowExceptions

run ToJson.new
