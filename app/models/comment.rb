class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :comments,
    class_name: :User

  belongs_to :post
end
