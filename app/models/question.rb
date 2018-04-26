class Question < ApplicationRecord
    validates :description, presesnce: true
    validates :thumbnail, allow_blank: true, allow_nil: true, format: { with: /\A.+\.(jpg|png|gif)\z/ }
    
    belogns_to :test
    has_many :answers
end
