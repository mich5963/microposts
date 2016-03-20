class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 , message: '50文字以下としてください' }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }
    has_secure_password
    validates :profile , length: { maximum: 200  , message: '200文字以下としてください'}
    validates :location , length: { maximum: 50  , message: '50文字以下としてください'} 
    validates :url , allow_nil: true , allow_blank: true ,length: { maximum: 2048 }, format: /\A#{URI::regexp(%w(http https))}\z/ 
    
    has_many :microposts
    
end
