class LandmarksController < ApplicationController

	get '/landmarks' do 
		@landmarks = Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/new' do 
		@figures = Figure.all
		@titles = Title.all 
		erb :'landmarks/new'
	end

	post '/landmarks' do 
	landmark = Landmark.new(params[:landmark])
	
	if !!params[:figure_id]
		landmark.figure = Figure.find(params[:figure_id])
		if !!params[:figure][:title_ids]
			landmark.figure.titles.clear	

			params[:figure][:title_ids].each do |title|

			landmark.figure.titles << Title.find(title)
			
			end
		end
	end

	if params[:figure][:name] != ""
		landmark.figure = Figure.new(params[:figure])
	end


	if params[:title][:name] != ""
		landmark.figure.titles << Title.new(params[:title])
	end

	landmark.save
	redirect to '/landmarks'
	end

	get '/landmarks/:id' do 
		@landmark = Landmark.find(params[:id])
		erb :'/landmarks/show'
	end

	get '/landmarks/:id/edit' do 
		@landmark = Landmark.find(params[:id])
		@titles = Title.all 
		@figure = Figure.all
		erb :'/landmarks/edit'
	end

	post '/landmarks/:id' do 
		landmark = Landmark.find(params[:id])
		landmark.name = params[:landmark][:name]
		landmark.year_completed = params[:landmark][:year_completed].to_i
		landmark.save
		redirect to "/landmarks/#{landmark.id}"
	end	

end
