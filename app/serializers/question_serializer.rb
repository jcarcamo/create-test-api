class QuestionSerializer < ActiveModel::Serializer
  has_many :answers
  attributes :id, :description, :thumbnail
end
