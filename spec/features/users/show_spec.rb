require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /user/id' do
    it "shows all of the user's information" do
      user_1 = User.create(
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")

      visit "/users/#{user_1.id}"

      expect(page).to have_content("#{user_1.name}")
      expect(page).to have_content("#{user_1.address}")
      expect(page).to have_content("#{user_1.city}")
      expect(page).to have_content("#{user_1.state}")
      expect(page).to have_content("#{user_1.zip}")
    end
  end
end
