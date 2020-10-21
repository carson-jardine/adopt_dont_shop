require 'rails_helper'

  describe Application do
    describe "relationship" do
      it {should belong_to :user}
      it {should have_many :pet_applications}
      it {should have_many(:pets).through(:pet_applications) }
    end

    describe "validations" do
      it { should validate_presence_of(:description).on(:update)}
    end
  end
