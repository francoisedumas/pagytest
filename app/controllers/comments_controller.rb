class CommentsController < ApplicationController
  before_action :set_blog_post, only: :create

  def index
    if params[:query].present?
      # Posgresql's version
      # sql_query = " \
      #   comments.body @@ :query \
      #   OR blog_posts.title @@ :query \
      #   OR blog_posts.body @@ :query \
      # "
      # SQlite's version
      sql_query = <<~SQL
        comments.body LIKE :query
        OR blog_posts.title LIKE :query
        OR blog_posts.body LIKE :query
      SQL
      @comments = Comment.joins(:blog_post).where(sql_query, query: "%#{params[:query]}%")
    end
  end

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
