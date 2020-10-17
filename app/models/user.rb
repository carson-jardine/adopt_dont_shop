class User < ApplicationRecord
  validates_presence_of :name
  has_many :reviews

  def highlighted_reviews
      reviews.minmax_by do |review|
        review.rating
    end
  end
end
