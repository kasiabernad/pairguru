require "rails_helper"

describe "Movies requests", type: :request do
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
end
