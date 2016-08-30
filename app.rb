require 'sinatra'
require 'byebug'
require "sinatra/cookies"
require "sinatra/content_for"
# enable :sessions

get '/' do
  erb :index
end

get '/ch_1' do
    @next = "/ch_2"
    @prev = "/"
    erb :ch_1
end

get '/ch_2' do
  @next = "/ch_3"
  @prev = "/ch_1"
  erb :ch_2
end

get '/ch_3' do
    @next = "/ch_4"
    @prev = "/ch_2"
    erb :ch_3
end

get '/ch_4' do
    @next = "/ch_5"
    @prev = "/ch_3"
    erb :ch_4
end

get '/ch_5' do
    @next = "/ch_6"
    @prev = "/ch_4"
    erb :ch_5
end

get '/ch_6' do
    @next = "/ch_5"
    @prev = "/test"
    erb :ch_6
end

get '/acerca_de' do
  erb :about
end