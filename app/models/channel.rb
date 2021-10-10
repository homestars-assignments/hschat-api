class Channel < ApplicationRecord
  has_many :messages, as: :targetable, dependent: :delete_all
  has_and_belongs_to_many :users
end
