class LikesController < ApplicationController
  before_action :login_required, :no_locked_required, :find_likeable

  def create
    if @likeable.user == current_user
      render nothing: true
      return
    end
    @likeable.likes.find_or_create_by user: current_user
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    case @commentable
    when Topic
      @comment = @commentable.comments.create(body: 'Your wish, my command.', user: current_user)
      if @comment
        Resque.enqueue(CommentNotificationJob, @comment.id)
      end
    when Comment
      @commentable.commentable.update(category_id: 1)
    end
  end

  def destroy
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    case @commentable
    when Topic
      @likeable.likes.where(user: current_user).destroy_all
      @commentable.comments.each do |c|
        c.destroy if c.user == current_user and c.body == 'Your wish, my command.'
      end
    when Comment
      render :forbidden
    end
  end

  private

  def find_likeable
    resource, id = request.path.split('/')[1, 2]
    @likeable = resource.singularize.classify.constantize.find(id)
  end
end
