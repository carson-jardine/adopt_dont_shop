class User < ApplicationRecord
  validates_presence_of :name
  has_many :reviews
  has_many :applications

  def highlighted_reviews
      reviews.minmax_by do |review|
        review.rating
    end
  end

  def average_user_rating
    reviews.average(:rating)
  end

  def self.name_exists?(param_name)
    exists?(name: param_name)
  end

end
