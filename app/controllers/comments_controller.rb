class CommentsController < ApplicationController
  def create
    @comment = Comment.create!(comment_params.merge(user:current_user, movie: movie))
    redirect_to movie_path(movie, anchor: "comment_#{comment.id}")
  rescue ActiveRecord::RecordInvalid => e
    redirect_to movie_path(movie), alert: t('.comment_uniqueness')
  end

  def destroy
    comment.destroy
    redirect_to movie_path(movie)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def movie
    @movie ||= Movie.includes(:comments).find(params[:movie_id])
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end
end
