require "rails_helper"

describe "handling comments", type: :feature do
  let(:movie) { create(:movie) }
  let(:user) { create(:user) }
  let(:comment) { create(:comment, user: user, movie: movie) }

  it "fills in form and submit comment" do
    sign_in user
    visit "/movies/#{movie.id}"

    within("#new_comment") do
      fill_in 'comment[body]', with: 'foooo'
    end
    click_button 'Send comment'

    expect(user.comments.length).to eq(1)
  end

  it "destroys comment" do
    user.comments << comment
    movie.comments << comment
    
    sign_in user
    visit "/movies/#{movie.id}"

    within("#comment_#{comment.id}") do
      click_link 'Remove comment'
    end

    expect(user.comments.length).to eq(1)
  end
end
