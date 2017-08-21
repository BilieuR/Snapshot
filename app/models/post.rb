class Post < ApplicationRecord
  acts_as_votable
  paginates_per 2

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Validations for posts
  validates :user_id, presence: true
  validates :image, attachment_presence: true
  validates :caption, length: { minimum: 3, maximum: 300 }, allow_blank: true

  has_attached_file :image, styles: { medium: "640x" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  # Only show followed users and the current user in dashboard
  scope :of_followed_users, -> (following_users) { where user_id: following_users }
  scope :of_current_user, -> (current_user) { where user_id: current_user }

  scope :of_current_and_followed_users, -> (following, current) {         self.of_followed_users(following).or(self.of_current_user(current))
  }
  
end
