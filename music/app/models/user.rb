class User < ApplicationRecord
    validates :username, :session_token, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    after_initialize :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(email, password)
        user = User.find_by(username: email)
        
        if user && user.is_password(password)
            return user
        else
            return nil
        end
    end
    def self.generate_session_token
        self.session_token = SecureRandom::url_safe_base64
    end
    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save! #save the session token into the database
        self.session_token  #return the session token
    end
    def ensure_session_token
        self.session_token  ||= SecureRandom::url_safe_base64
    end
    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end
    def is_password?(password)
        password_object = BCrypt.new(self.password_digest)
        password_object.is_password?(password)
    end
end