require 'pry'
require 'sinatra'
# using rerun instead of sinatra reloader
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# this will store your users
users = []

# this will store an id to user for your users
# you'll need to increment it every time you add
# a new user, but don't decrement it
id = 1

# routes to implement:
#
# GET / - show all users
get '/' do
  @users = users
  erb :index
end

# GET /users/new - display a form for making a new user
get '/users/new' do
  erb :new
end

# POST /users - create a user based on params from form
post '/users' do
  users.push ({ first: params[:first], last: params[:last], id: id })
  id += 1
  redirect '/'
end

# GET /users/:id - show a user's info by their id, this should display the info in a form
get '/users/:id' do
  @user = users.find { |user| user[:id] == params[:id].to_i }
  erb :edit
end

# PUT /users/:id - update a user's info based on the form from GET /users/:id
put '/users/:id' do
  index = users.index{ |u| u[:id] == params[:id].to_i }
  users[index] = { :first => params[:first], :last => params[:last], :id => params[:id].to_i }
  redirect '/'
end

# DELETE /users/:id - delete a user by their id
delete '/users/:id' do
  users.delete_if { |user| user[:id] == params[:id].to_i }
  redirect '/'
end