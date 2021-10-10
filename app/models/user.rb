class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, uniqueness: true

  has_many :sent_messages, class_name: 'Message', foreign_key: :user_id, dependent: :delete_all
  has_many :received_messages, class_name: 'Message', as: :targetable, dependent: :delete_all
  has_and_belongs_to_many :channels
end
