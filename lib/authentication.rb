require "jwt"

class Authentication
  ALGORITHM = "HS256".freeze

  class << self
    def encode payload
      JWT.encode(payload, ENV["auth_secret"], ALGORITHM)
    end

    def decode token
      JWT.decode(token, ENV["auth_secret"], true, algorithm: ALGORITHM).first
    end
  end
end
