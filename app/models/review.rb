class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelter

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content

  validates :reviewer_name, if: User.exists?(name: params[:reviewer_name])

end
