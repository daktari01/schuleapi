class User < ApplicationRecord
  has_secure_password
  # mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :username, presence: true, uniqueness: true
  validates :password, format: { with: /(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&]){8,}/ },
            if: -> { new_record? || !password.nil? }
end
