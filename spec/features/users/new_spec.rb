require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /users/new' do
    it "User can fill in form" do
      visit "/users/new"

      fill_in "user[name]",      with: "Louis Jardine"
      fill_in "user[address]",   with: "2525 Wewatta Way"
      fill_in "user[city]",      with: "Denver"
      fill_in "user[state]",     with: "CO"
      fill_in "user[zip]",       with: "80216"

      click_button "Create User"

      user = User.last

      expect(current_path).to eq("/users/#{user.id}")

      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
    end
  end
end
