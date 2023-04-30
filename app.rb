require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative "lib/cookbook"
require_relative "lib/recipe"


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

post "/recipes" do
  name = params[:name]
  description = params[:description]
  rating = params[:rating]
  cookbook.create(Recipe.new(name: name, description: description, rating: rating))
  redirect "/"
end

get "/recipes/:index" do
  cookbook.destroy(params[:index].to_i)
  redirect to "/"
end
