class Users::TopicsController < Users::ApplicationController
  def index
    @topics = @user.topics.includes(:category).order(id: :desc).page(params[:page])
  end

  def likes
    @topics = @user.like_topics.where.not(id: @user.like_topics.joins(:comments).where(comments: {user: @user, likes_count: 1}).ids).order(id: :desc).page(params[:page])
    render :index
  end

  def done
    @topics = @user.like_topics.joins(:comments).where(comments: {user: @user, likes_count: 1}).order(id: :desc).page(params[:page])
    render :index
  end
end
