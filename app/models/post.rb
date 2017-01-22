class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  # Validations for posts
  validates :caption, length: { minimum: 3, maximum: 300 }, allow_blank: true
  validates :user_id, presence: true
  validates :image, attachment_presence: true
  has_attached_file :image, styles: { medium: "640x" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
