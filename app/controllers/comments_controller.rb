class CommentsController < ApplicationController

	before_filter :authenticate_user!, except: [:destroy, :edit]
	
	def create

	 if user_signed_in?
		@comment= Comment.new(comment_params)
		@comment.article_id= params[:article_id]
		@article=Article.find(params[:article_id])
		@comment.save
      
       	respond_to do |format|
       	   if  @comment.save
       	 	@comment=Comment.new
          	flash.notice = " comment posted successfully !"	
        	format.js
		   else
		 	format.js
		   end
	    end
	  else
	  	flash.notice = " login first !"	
	  	redirect_to article_path(@article)
	  end
	end

	def edit
		
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])
	end

	def update
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])
		@comment.update(comment_params)
		respond_to do |format|
		   if @comment.update(comment_params)
			   if @comment != nil
			   flash.notice = " Comment updated successfully !"	
			   	format.html {redirect_to article_path(@article)}
			   	format.js
			   end
		   else
			 flash.notice = "Your comment can't be blank!"
					
				format.html {render :edit}
			   	format.js
		   end
		end
	end
	def destroy
		
		@comment = Comment.find(params[:id])
		
		@comment.destroy
		@article = Article.find(params[:article_id])
		respond_to do |format|
		   flash.notice = " comment deleted successfully !"	
		  #format.html {redirect_to article_path(@article)}
		  format.js
		end
	end

	



	def comment_params
		params.require(:comment).permit(:body, :author_name, :user_id)
	end
end
