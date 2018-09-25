class User < ApplicationRecord
  authenticates_with_sorcery!

  validates_email_format_of :email

  has_many :posts, foreign_key: :author_id, dependent: :destroy

  def self.load_by_token(token)
    payload = JWT.decode(token, Rails.application.credentials.secret_key_base, 'HS256')[0]
    find_by(id: payload.dig('user_id')) if payload.is_a?(Hash) && payload.key?('user_id')
  rescue JWT::ExpiredSignature, JWT::DecodeError
    nil
  end
end
