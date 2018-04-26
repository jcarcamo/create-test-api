class Answer < ApplicationRecord
    validates :description, presence: true
    enum status: [:correct, :incorrect]
    belongs_to :question
end
