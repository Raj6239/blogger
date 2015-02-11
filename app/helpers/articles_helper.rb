module ArticlesHelper

	def article_params
  	params.require(:article).permit(:title, :body, :tag_list, :photo,:usre_id)
	end
end
