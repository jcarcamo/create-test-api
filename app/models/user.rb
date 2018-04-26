class User < ApplicationRecord
    has_secure_password

    validates :lname, presence: true
    validates :fname, presence: true
    validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }

    has_many :tests

    def generate_json_api_error
        json_error = {"errors": []}
        errors.messages.each do |err_type, messages|
          messages.each do |msg|
            json_error[:errors] << {"detail": "#{err_type} #{msg}", "source": {"pointer": "user/err_type"}}
            end
        end
        json_error
    end
end
