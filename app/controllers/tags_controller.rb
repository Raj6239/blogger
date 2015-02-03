class TagsController < ApplicationController

	def edit
		@tag= Tag.find(params[:id])
	end

	def show

		@tag= Tag.find(params[:id])
		
	end

	def index
		@tags= Tag.all
		
	end

	def update
		@tag= Tag.find(params[:id])
		@tag.update(tag_params)

			redirect_to tags_path

	end

	def destroy
		@tag= Tag.find(params[:id])
		@tag.destroy
		redirect_to tags_path
	end

	def tag_params
  	params.require(:tag).permit(:name)
	end
end