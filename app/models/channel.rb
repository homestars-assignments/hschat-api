class Channel < ApplicationRecord
  has_many :messages, as: :targetable
end
