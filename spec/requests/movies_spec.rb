require "rails_helper"

describe "Movies requests", type: :request do
  let(:current_user) { create(:user) }
  let(:movie) { create(:movie) }

  describe "movies list" do
    let!(:movies) { create_list(:movie, 5) }
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it 'displays additional info' do
      visit "/movies/"
      expect(page).to have_selector("p", text: "Rating")
    end
  end

  describe 'movie page' do
    let!(:movie) { create(:movie) }
    it 'displays additional info' do
      visit "/movies/" + movie.id.to_s
      expect(page).to have_selector("h5", text: "Plot")
    end
  end

  describe 'send_info' do
    let(:movie) { create(:movie) }

    it 'sends email with sidekiq worker' do
      assert_equal 0, Sidekiq::Worker.jobs.size
      MovieInfoMailer.send_info(current_user, movie).deliver_later
      assert_equal 1, Sidekiq::Worker.jobs.size
    end
  end

  describe 'export' do
    it 'export movies with sidekiq worker' do
      assert_equal 0, Sidekiq::Worker.jobs.size
      MoviesCsvExportJob.perform_later(current_user)
      assert_equal 1, Sidekiq::Worker.jobs.size
    end
  end

  describe "movie page for logged in user" do
    let(:user) { create(:user)}

    it "displays comment form" do
      sign_in user
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("form", id: 'new_comment')
    end
  end

  describe "movie page for not logged in user" do
    it "doesn't display comment form" do
      sign_in nil

      visit "/movies/#{movie.id}"
      expect(page).to_not have_selector("form", id: 'new_comment')
    end
  end
end
