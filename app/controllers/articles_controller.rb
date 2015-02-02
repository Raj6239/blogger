class ArticlesController < ApplicationController
	def index
       @articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		
	end

	def edit
  		@article = Article.find(params[:id])
	end


	def new
		@article= Article.new
	end
   
	def update
  		@article = Article.find(params[:id])
  		@article.update(article_params)

  		 flash.notice = "Your Article '#{@article.title}' Updated!"

  			redirect_to article_path(@article)
	end


	def create
		@article = Article.new
		@article.title = params[:article][:title]
		@article.body = params[:article][:body]
		@article.save
		   flash.notice = " Article '#{@article.title}' created successfully !"	
			redirect_to article_path(@article)

	end

	def destroy
		@article= Article.find(params[:id])
		@article.destroy
			flash.notice = " Article '#{@article.title}' destroy successfully !"	
			redirect_to articles_path
	end


	include ArticlesHelper
end
