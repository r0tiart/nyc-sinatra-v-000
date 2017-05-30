class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		erb :'/figures/index'
	end

	get '/figures/new' do 
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'/figures/new'
	end

	post '/figures' do 
		figure = Figure.new(name: params[:figure][:name])
		
		if !!params[:figure][:landmark_ids]
			params[:figure][:landmark_ids].each do |landmark|
				figure.landmarks << Landmark.find(landmark)
			end
		end

		if !!params[:figure][:title_ids]
			params[:figure][:title_ids].each do |title|
				figure.titles << Title.find(title)
			end
		end

		if params[:title][:name] != ""
			figure.titles << Title.new(params[:title])
		end

		if params[:landmark][:name] != ""
			figure.landmarks << Landmark.new(params[:landmark])
		end

		figure.save
		redirect to '/figures'
	end

	get '/figures/:id' do 
		@figure = Figure.find(params[:id])
		erb :'/figures/show'
	end

	get '/figures/:id/edit' do 
		@figure = Figure.find(params[:id])
		@titles = Title.all 
		@landmarks = Landmark.all
		erb :'/figures/edit'
	end

	post '/figures/:id'do
		figure = Figure.find(params[:id])

		if params[:figure][:name] != ""
			figure.name = params[:figure][:name] 
		end

		if !!params[:figure][:landmark_ids]
			params[:figure][:landmark_ids].each do |landmark|
				figure.landmarks << Landmark.find(landmark)
			end
		end

		if !!params[:figure][:title_ids]
			params[:figure][:title_ids].each do |title|
				figure.titles << Title.find(title)
			end
		end

		if params[:title][:name] != ""
			figure.titles << Title.new(params[:title])
		end

		if params[:landmark][:name] != ""
			figure.landmarks << Landmark.new(params[:landmark])
		end

		figure.save
		redirect to "/figures/#{@figure.id}"
	end	
end