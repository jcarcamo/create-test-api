class TestSerializer < ActiveModel::Serializer
  has_many :questions
  attributes :id, :description, :status
end
