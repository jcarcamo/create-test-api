class Question < ApplicationRecord
    validates :description, presence: true
    validates :thumbnail, allow_blank: true, allow_nil: true, format: { with: /\A.+\.(jpg|png|gif)\z/ }

    belongs_to :test
    has_many :answers
end
