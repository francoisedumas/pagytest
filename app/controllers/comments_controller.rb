class CommentsController < ApplicationController
  before_action :set_blog_post

  def create
    comment = Comment.new(comment_params)
    comment.blog_post = @blog_post
    if comment.save
      # Instead of redirecting like we normally would, we render a partial for our Stimulus controller to handle
      # Note that we're just rendering HTML here, no need to render jbuilders or js partials
      # render partial: 'show', locals: { comment: comment }, status: :ok
      redirect_to @blog_post
    else
      render partial: 'form', locals: { comment: comment }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end
end
