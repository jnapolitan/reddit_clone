class Post < ApplicationRecord
  validates :title, :content, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User,
    inverse_of: :posts

  belongs_to :sub

  has_many :comments,
    dependent: :destroy
end
