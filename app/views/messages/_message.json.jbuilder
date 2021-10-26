json.extract! message, :id, :body, :user_id, :created_at, :updated_at
json.user do
  json.user_id message.user_id
  json.name message.user.name
  json.email message.user.email
end
json.url message_url(message, format: :json)
