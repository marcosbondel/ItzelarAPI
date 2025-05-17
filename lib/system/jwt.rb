module System
    module Jwt
        ALGORITHM = 'HS512'
        JWT_SECRET = Rails.application.credentials.secret_key_base

        def encode payload
            
            payload[:exp] = 24.hours.from_now.to_i unless payload[:exp]

            payload[:exp] = payload[:exp].to_i
            payload[:iat] = Time.now.to_i
            puts ALGORITHM
            puts JWT_SECRET
            JWT.encode(payload, JWT_SECRET, ALGORITHM)
        end

        def decode token
            JWT.decode(token, JWT_SECRET, true, { algorithm: ALGORITHM })
        rescue JWT::DecodeError => e
            Rails.logger.error "JWT Decode Error: #{e.message}"
            nil
        end
    end
end