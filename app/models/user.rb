class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    has_secure_password

    validates :first_name, presence: true, length: { minimum: 1 }
    validates :last_name, presence: true, length: { minimum: 1 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

    def get_name
        self.first_name
    end 

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.password = SecureRandom.hex
        end
    end
end