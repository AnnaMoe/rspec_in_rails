class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  default_scope { order(created_at: :desc)}
  belongs_to :user
  # when article gets deleted, delete the dependent comments as well
  has_many :comments, dependent: :destroy
end
