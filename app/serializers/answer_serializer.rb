class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :question_id
end
