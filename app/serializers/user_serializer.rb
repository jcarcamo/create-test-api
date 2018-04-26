class UserSerializer < ActiveModel::Serializer
  attributes :id, :fname, :lname, :email
end
