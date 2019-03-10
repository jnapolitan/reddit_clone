class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, presence: :true { message: 'Must have at least one sub!' }

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User,
    inverse_of: :posts

  has_many :post_subs,
    inverse_of: :post,
    dependant: :destroy
  
  has_many :subs,
    through: :post_subs,
    source: :sub
end
