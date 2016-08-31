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
    @next = "/test"
    @prev = "/ch_5"
    erb :ch_6
end

get '/closure' do
  @next = "/acerca_de"
  @prev = "/eval_1"
  erb :ch_7
end

get '/acerca_de' do
  @next = "/"
  @prev = "/ch_7"
  erb :about
end

get '/test' do
  @prev = "/ch_6"
  @hide_next = true
  erb :test_intro
end

# Quiz about Change Management
get '/eval_1' do
  @hide_next = true
  @hide_prev = true
  erb :eval_1
end

# Drag and drop
post '/eval_2' do
  cookies[:eval_1] = eval_1(params)
  erb :eval_2 , layout: false
end

# Alphabet Soup
post '/eval_3' do
  cookies[:eval_2] = eval_2(params)
  erb :eval_3, layout: false
end

# True and False
post '/eval_4' do
  cookies[:eval_3] = eval_3(params)
  erb :eval_4, layout: false
end

post '/eval_final' do
  cookies[:eval_4] = eval_4(params[:tinput].to_i)
  cookies[:eval_4_time] = params[:tinput]
  @results = eval_final(cookies[:eval_1].to_i, cookies[:eval_2].to_i, cookies[:eval_3].to_i ,cookies[:eval_4].to_i)
  erb :eval_result, layout: false
end

# --------------------------------------
# Evaluation Functions
def eval_1(data)
  points = 0
  points +=1 if data[:selectionOne] == "option2"
  points +=1 if data[:selectionTwo] == "option2"
  points +=1 if data[:selectionThree] == "option3"
  points +=1 if data[:selectionFour] == "option2"
  points +=1 if data[:selectionFive] == "option1"
  return points
end

def eval_2(data)
  points = 0
  points +=1 if data[:drop_1] == "4"
  points +=1 if data[:drop_2] == "2"
  points +=1 if data[:drop_3] == "1"
  points +=1 if data[:drop_4] == "5"
  points +=1 if data[:drop_5] == "3"
  return points
end

def eval_3(data)
  points = 0
  points +=1 if data[:selectionOne] == "option3"
  points +=1 if data[:selectionTwo] == "option3"
  points +=1 if data[:selectionThree] == "option2"
  points +=1 if data[:selectionFour] == "option1"
  return points
end

def eval_4(segs)
  case segs
  when 0..120
    points = 6
  when 121..240
    points = 3
  else
    points = 1
  end
  return points
end



def eval_final(ev1, ev2, ev3, ev4)
  total_p = ev1 + ev2 + ev3 + ev4
  case total_p
  when 20
    result = "A - Puntaje Perfecto!"
  when 15..19
    result = "B - Bien Hecho!."
  when 10..14
    result = "C - Hay que esforzarnos más."
  when 5..9
    result = "D - Deficiente"
  else
    result = "E - Reprobado.."
  end
  return result
end
