class User < ActiveRecord::Base
    
    has_many :tasks
    has_many :projects, through: :tasks

    scope :most_projects, -> {joins(:projects).group(:user_id).order("COUNT(*) DESC").first}


    before_save { self.email = email.downcase }
    has_secure_password

    if has_provider = "facebook"
    else 
        validates :first_name, presence: true, length: { minimum: 1 }
        validates :last_name, presence: true, length: { minimum: 1 }
    end 

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

    def get_name
        self.first_name
    end 

    def has_provider
        self.provider
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