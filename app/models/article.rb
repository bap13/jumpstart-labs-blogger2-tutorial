class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :body, presence: true
  
  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
  
  def tag_list=(tags_string)
    tags = tags_string.split(",").collect { |t| t.downcase.strip }.uniq
    new_or_found_tags = tags.collect { |t| Tag.find_or_create_by(name: t) }
    self.tags = new_or_found_tags
  end
end
