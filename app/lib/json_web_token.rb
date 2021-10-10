##
# To be used by controllers for token based authentication
#
class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key)
  end

  def self.decode(token)
    decoded = JWT.decode(token, secret_key)[0]
    HashWithIndifferentAccess.new decoded
  end

  private

  def self.secret_key
    Rails.application.secrets.secret_key_base.to_s
  end
end
