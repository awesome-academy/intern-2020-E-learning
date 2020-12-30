class CommentsController < ApplicationController
  before_action :get_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new \
      comment_params.merge(user_id: current_user.id)
    if @comment.save
      respond_to :js
    else
      render :new
    end
  end

  private

  def get_commentable
    resource, id = request.path.split("/")[2, 2]
    @commentable = resource.singularize.classify.constantize.find id
  end

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
