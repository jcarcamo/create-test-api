class UserSerializer < ActiveModel::Serializer
  has_many :tests
  attributes :id, :fname, :lname, :email
  #This was an attempt to get all the information from one request
  #https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/getting_started.md
  #It didn't work unfortunately
  class TestSerializer < ActiveModel::Serializer
    has_many :questions
    attributes :id, :description, :status
    class QuestionSerializer < ActiveModel::Serializer
      has_many :answers
      attributes :id, :description, :thumbnail
      class AnswerSerializer < ActiveModel::Serializer
        attributes :id, :description, :status
      end
    end
  end
end
