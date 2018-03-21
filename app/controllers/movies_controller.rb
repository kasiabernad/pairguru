class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.includes(:genre).all.decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back fallback_location: root_path, notice: "Email sent with movie info"
  end

  def export
    MoviesCsvExportJob.perform_later(current_user)
    redirect_to root_path, notice: "Movies exported"
  end
end
