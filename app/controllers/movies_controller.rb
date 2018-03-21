class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.includes(:genre).all.decorate
  end

  def show; end

  def send_info
    MovieInfoMailer.send_info(current_user, movie).deliver_later
    redirect_to :back, notice: "Email sent with movie info"
  end

  def export
    MoviesCsvExportJob.perform_later(current_user)
    redirect_to root_path, notice: "Movies exported"
  end

  helper_method :movie
  def movie
    @movie ||= Movie.includes(:comments).find(params[:id]).decorate
  end

  helper_method :comments
  def comments
    @comments ||= movie.comments.order(created_at: :desc).decorate
  end
end
