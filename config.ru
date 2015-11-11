require "sinatra"
require('./app/app')
Dir.glob('./app/{models,controllers,services}/*.rb').each { |file| require file }

map('/') { run ApplicationController }
map('/twitter') { run TwitterController }
