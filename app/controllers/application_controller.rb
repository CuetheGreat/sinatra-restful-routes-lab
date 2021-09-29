class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    recipe.save
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :show
    else
      redirect '/recipes'
    end
  end

  delete '/recipes/:id' do
    recipe = Recipe.find_by(id: params[:id])
    recipe.delete
    redirect '/recipes'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    recipe = Recipe.find_by(id: params[:id])

    recipe.name = params[:name] unless params[:name].empty?
    recipe.ingredients = params[:ingredients] unless params[:ingredients].empty?
    recipe.cook_time = params[:cook_time] unless params[:cook_time].empty?
    recipe.save
    redirect "/recipes/#{recipe.id}"
  end
end
