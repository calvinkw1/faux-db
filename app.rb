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
  redirect to '/'
end

# GET /users/:id - show a user's info by their id, this should display the info in a form
get '/users/:id' do
  users.each do |user|
    if user[:id] == params[:id].to_i
      @user = user
    end
  end
  erb :edit
end

# PUT /users/:id - update a user's info based on the form from GET /users/:id
put '/users/:id' do
  # teacher = teachers[params[:id].to_i - 1]

  # teacher[:first] = params[:first]
  # teacher[:last] = params[:last]

  # redirect to '/'

  @user = users[:first], users[:last]

  @user[:first] = params[:first]
  @user[:last] = params[:last]

  redirect to '/users'
end

# DELETE /users/:id - delete a user by their id
