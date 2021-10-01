class Message < ApplicationRecord
  belongs_to :user
  belongs_to :targetable, polymorphic: true
end
