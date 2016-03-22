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

    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower   


    # 他のユーザーをフォローする
    def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
    end
    
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
    following_users.include?(other_user)
    end

    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    # micropost のお気に入り登録関連
    has_many :my_favorites, class_name:  "Favorite", foreign_key: "user_id", dependent: :destroy
                                        
    has_many :my_favorite_microposts, through: :my_favorites, source: :micropost

    def add_favorite(other_micropost)
        my_favorites.find_or_create_by(micropost_id: other_micropost.id)
    end
    
    def remove_favorite(other_micropost)
        my_favorite = my_favorites.find_by(micropost_id: other_micropost.id)
        my_favorite.destroy if my_favorite
    end
    
    def favorites?(other_micropost)
        my_favorite_microposts.include?(other_micropost)
    end

end
