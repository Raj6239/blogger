class ArticlesController < ApplicationController

before_filter :authenticate_user!, except: [:new, :create, :index, :show]
before_filter :autherise_user, :only => [:edit]
before_filter :check_active, :only => [:new, :edit]

	def index
       @articles = Article.all
       @user = User.all
	end
	def my_articles
		@articles = Article.all
        @user =User.find(params[:user_id])
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
       
        if params[:images] != nil
             
  			params[:images].each do |image|
			@attachment=Attachment.new
			@attachment.article_id=@article.id
			@attachment.image=image
			@attachment.save!
		    end
        end
        if @article.save(article_params)	  		
  		 flash.notice = " '#{@article.title}' Updated!"

  			redirect_to article_path(@article)
  		else
  			render :edit
  		end
	end


	def create
		@article = Article.new
		@article.title = params[:article][:title]
		@article.body = params[:article][:body]
		@article.tag_list = params[:article][:tag_list]
		@article.photo = params[:article][:photo]
		@article.user_id = params[:article][:user_id]
		@article.save
		
		
		
			if @article.save
			  if params[:images] != nil
				params[:images].each do |image|
				@attachment=Attachment.new
				@attachment.article_id=@article.id
				@attachment.image=image
				@attachment.save
				end
			 end
		   flash.notice = " Article '#{@article.title}' created successfully !"	
		
			redirect_to article_path(@article)
		else
			render :new
	end
end

	def destroy
		@article= Article.find(params[:id])
		@article.destroy
			flash.notice = " Article '#{@article.title}' destroy successfully !"	
			redirect_to articles_path
	end
	def autherise_user
		@article =Article.find(params[:id])
		
	
		unless current_user.role== "admin" || current_user.email== @article.user.email
   		redirect_to root_path
   	end
   		
 	end
 	def check_active

  unless (user_signed_in?) && (current_user.account_status ==true)
  	flash.notice = "Sorry..!! you need to activate your account first."
    redirect_to root_path
  end
    
  end

	def delete_attachment
		@article= Article.find(params[:article_id])
		@attachments= Attachment.find(params[:id])
		@attachments.destroy
		      redirect_to article_path(@article)
	end

	def user_details
		@users = User.all
		
	end
	def delete_user
		@user = User.find(params[:user_id])
	    if  current_user.role =='superadmin'
        @user.destroy
          redirect_to user_details_path
         else
	     	flash.notice = "Sorry..!! you haven't this Right."
	     	redirect_to user_details_path
	     end

	end
	def change_role
		@user = User.find(params[:user_id])
		if current_user.role =='superadmin'
			if @user.account_status== true		
			         if @user.role == 'admin'
			         	@user.role = 'user'
			         else
			         	 @user.role = 'admin'
			         end
			         @user.save
			             redirect_to user_details_path
			 else
			 	flash.notice = "user's account is not active."
					redirect_to user_details_path
			 end
	     else
	     	flash.notice = "Sorry..!! you haven't this Right."
	     	redirect_to user_details_path
	     end

	end

	def user_profile
		@user= User.find(params[:user_id])
	end

	def deactivate_account
		@user= User.find(params[:user_id])
        
		if @user.account_status == false
			@user.account_status = true
			@user.save
		flash.notice = "your account Activated successfully."
		     redirect_to user_profile_path(@user)
		else

				   if @user.role=='superadmin'
				   	  flash.notice = "you have to make someone Superadmin."
				   	     redirect_to user_details_path
				   else
					@user.account_status = false
					@user.save
				flash.notice = "you have been deactivated from blogger."
				# debugger
				sign_out current_user 
				 	redirect_to root_path
				 end
		end	
			
	end
	def delete_account
		@user= User.find(params[:user_id])
		if @user.role !='superadmin'
		@user.destroy
		flash.notice = "Your account has been removed from blogger."
			redirect_to articles_path
		else
			flash.notice = "you have to make someone Superadmin."
			redirect_to user_details_path
		end
			
	end

	def make_superadmin
	   	if current_user.role =='superadmin'
		@user= User.find(params[:user_id])
		      if @user.account_status == true
		      	current_user.role = 'user'
				@user.role = 'superadmin'
				current_user.save
				@user.save
				   redirect_to user_details_path
				else
					flash.notice = "user's account is not active."
					redirect_to user_details_path
				end
		 else
		 	flash.notice = "Sorry..!! you haven't this Right."
		 	redirect_to user_details_path
		 end
	end


	include ArticlesHelper
end
