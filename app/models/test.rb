class Test < ApplicationRecord
    validates :description, presence: true
    enum status: [:published, :unpublished]
    belongs_to :user
    has_many :questions
end
