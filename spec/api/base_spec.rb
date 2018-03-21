require 'rails_helper'

describe 'API::Base' do

  context 'GET /movies' do
    let!(:movies) { create_list(:movie, 5) }

    describe 'developers scope' do
      it 'should return success in developers scope' do
        get '/api/devs/movies'
        expect(response.status).to eq(200)
      end

      it 'should display movies with genre info in developers scope' do
        get '/api/devs/movies'
        movies = JSON.parse(response.body)
        expect(movies.first).to have_key('genre')
      end
    end

    describe 'users scope' do
      it 'should return success in users scope' do
        get '/api/movies'
        expect(response.status).to eq(200)
      end

      it 'should display movies' do
        get '/api/movies'
        movies = JSON.parse(response.body)
        expect(movies.size).to eq(5)
      end
    end
  end

  context 'GET /movie/:id' do
    let!(:movie) { create(:movie) }
    describe 'developers scope' do
      it 'should return success in users scope' do
        get "/api/devs/movies/#{movie.id}"
        expect(response.status).to eq(200)
      end
    end

    describe 'developers scope' do
      it 'should return success in users scope' do
        get "/api/movies/#{movie.id}"
        expect(response.status).to eq(200)
      end
    end
  end
end
