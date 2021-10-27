class CommentsController < ApplicationController
  before_action :set_project

  def create
    comment = Comment.new(comment_params)
    comment.project = @project
    if comment.save
      # Instead of redirecting like we normally would, we render a partial for our Stimulus controller to handle
      # Note that we're just rendering HTML here, no need to render jbuilders or js partials
      render partial: 'show', locals: { comment: comment }, status: :ok
    else
      render partial: 'form', locals: { comment: comment }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
