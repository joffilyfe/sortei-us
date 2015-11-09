require "sinatra"
require('./app/app')
Dir.glob('./app/{models,controllers}/*.rb').each { |file| require file }

map('/') { run ApplicationController }
map('/twitter') { run TwitterController }
