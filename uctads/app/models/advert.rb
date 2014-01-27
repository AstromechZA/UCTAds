class Advert < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, length: {minimum: 10}
end
