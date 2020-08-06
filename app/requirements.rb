require 'socket'
require 'json'
require 'sequel'
Sequel::Model.plugin :json_serializer

DB = Sequel.connect('postgres://mad_scientists:2@localhost:5432/mad_scientists')

require_relative 'byg/classes/classes.rb'
require_relative 'byg/models/models.rb'
require_relative 'byg/rest/rest.rb'