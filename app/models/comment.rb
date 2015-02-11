class Comment < ActiveRecord::Base
	belongs_to :article

	belongs_to :user


	#validates :author_name, :presence => { :message => "Author can't be blank" }
	validates :body, :presence => { :message => "your comment can't be blank??" }
end
