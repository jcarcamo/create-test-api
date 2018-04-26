class TestSerializer < ActiveModel::Serializer
  has_many :questions
  attributes :id, :description, :status, :user_id
end
