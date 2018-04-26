class Answer < ApplicationRecord
    validates :description, presesnce: true
    enum status: [:correct, :incorrect]
    belongs_to :question
end
