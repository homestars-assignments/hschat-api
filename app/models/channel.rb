class Channel < ApplicationRecord
  has_many :messages, as: :targetable, dependent: :delete_all
end
