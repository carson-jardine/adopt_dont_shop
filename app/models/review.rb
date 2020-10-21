class Review < ApplicationRecord
  before_save :default_picture
  belongs_to :user
  belongs_to :shelter

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content

  def default_picture
    self.optional_image = 'http://cdn.akc.org/content/article-body-image/black_labrador_retriever_puppies.jpg' if self.optional_image == ""
  end
end
