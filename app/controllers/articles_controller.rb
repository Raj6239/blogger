class ArticlesController < ApplicationController

before_filter :authenticate_user!, except: [:new, :create, :index, :show]

	def index
       @articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
	
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

  		params[:images].each do |image|
		@attachment=Attachment.new
		@attachment.article_id=@article.id
		@attachment.image=image
		@attachment.save
	   end
  		 flash.notice = "Your Article '#{@article.title}' Updated!"

  			redirect_to article_path(@article)
	end


	def create
		@article = Article.new
		@article.title = params[:article][:title]
		@article.body = params[:article][:body]
		@article.tag_list = params[:article][:tag_list]
		@article.photo = params[:article][:photo]
		@article.save
		
		params[:images].each do |image|
		@attachment=Attachment.new
		@attachment.article_id=@article.id
		@attachment.image=image
		@attachment.save
		end

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
