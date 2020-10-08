require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelter' do
    it "can navigate to New Shelter page" do
      visit "/shelters"
      click_on "New Shelter"
      expect(page).to have_content("Enter a New Shelter:")
      expect(page).to have_button("Create Shelter")
    end
  end
end
