module V1
  module Entities
    class Movie < Grape::Entity
      expose :title, :id
    end

    class Genre < Grape::Entity
      expose :id, :name
      expose :number_of_movies
    end

    class MovieWithGenre < V1::Entities::Movie
      expose :genre, using: Genre
    end
  end

  class Base < Grape::API
    version 'v1', using: :header, vendor: 'pairguru'
    prefix :api
    format :json

    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(message: e.message, status: 404)
    end

    namespace :devs do
      resource :movies do
        desc 'Return all movies with data format requested by developers'

        get '/' do
          movies = Movie.includes(:genre).all
          present  movies, with: V1::Entities::MovieWithGenre
        end

        desc 'Return a movie with given ID and with data format requested by developers'
        params do
          requires :id, type: Integer, desc: 'Movie id.'
        end

        route_param :id do
          get do
            movie = Movie.find(params[:id])
            present movie, with: V1::Entities::MovieWithGenre
          end
        end
      end
    end

    resource :movies do
      desc 'Return all movies'

      get '/' do
        movies = Movie.all
        present  movies, with: V1::Entities::Movie
      end

      desc 'Return a movie with given ID.'
      params do
        requires :id, type: Integer, desc: 'Movie id.'
      end

      route_param :id do
        get do
          movie = Movie.find(params[:id])
          present movie, with: V1::Entities::Movie
        end
      end
    end
  end
end
