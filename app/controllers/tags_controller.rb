class TagsController < ApplicationController

	before_filter :authenticate_user!, only: [:destroy, :edit]

	def edit
		@tag= Tag.find(params[:id])
	end

	def show
       # @article = Article.find(params[:id])
		@tag= Tag.find(params[:id])
		if params[:tag]

	else
		@article = Article.find(params[:article_id])
	end
		# @art= Article.find(params[:art_id])
		
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
