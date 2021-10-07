class User < ApplicationRecord
  has_many :sent_messages, class_name: 'Message', foreign_key: :user_id, dependent: :delete_all
  has_many :received_messages, class_name: 'Message', as: :targetable, dependent: :delete_all
end
