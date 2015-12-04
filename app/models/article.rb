class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image, styles: { thumb: "180x180>" }
  validates_attachment_content_type :image,
                      :content_type => ["image/jpg", "image/jpeg", "image/png"]
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
