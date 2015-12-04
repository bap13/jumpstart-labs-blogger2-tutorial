class Comment < ActiveRecord::Base
  belongs_to :article
  has_many :taggings
  validates :author_name, :body, presence: true
end
