require "rails_helper"

describe "Top commentors requests", type: :request do

  describe "Top commentors list" do
    let!(:user) { create(:user) }
    let!(:comment) { create(:comment, user: user) }
    let!(:top_commenter) { create(:user, :with_comments)}
    let!(:user_with_old_comments) { create(:user, :with_old_comments)}

    it "displays top commentors page" do
      visit "/top_commenters/"
      expect(page).to have_selector("table th", text: 'Comments count')
    end

    it "displays author's name" do
      visit "/top_commenters/"
      expect(page).to have_text(user.name)
    end

    it "displays users in order of recent comments count" do
      visit "/top_commenters/"
      first_in_table = find('table tr:nth-child(1) > td:nth-child(2)').text

      expect(first_in_table).to eq(top_commenter.name)
      expect(page).to have_selector("table tr", count: 2)
    end
  end
end
