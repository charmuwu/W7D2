class User < ApplicationRecord
    validates :session_token, uniqueness: true, presence: true

    def self.generate_session_token
        self.session_token = SecureRandom::url_safe_base64
    end
    def reset_session_token!
        self.session_token = User.generate_session_token
    end
    def ensure_session_token
    end
    def password=(password)
        self.password_digest = BCrypt.create(password)
    end
    def is_password?(password)
        password_object = BCrypt.new(self.password_digest)
        password_object == BCrpyt.new(password)
    end
end