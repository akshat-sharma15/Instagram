require 'open-uri'

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :picture
  has_many :comments
  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(" ")
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, name: auth.info.name, username: username = auth.info.email.split('@').first, email: auth.info.email, password: Devise.friendly_token[0, 20])
    user.skip_confirmation!
    user.confirmed_at ||= DateTime.now

    if auth.info.image.present? && user.picture.blank?
      user.picture.attach(io: URI.open(auth.info.image), filename: "#{user.name}_profile_picture.jpg")
    end

    user.save
    user
  end
end
