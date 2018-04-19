class User < ActiveRecord::Base
  has_secure_password
  has_many:events
  has_many:comments
  has_many:joins
  has_many:events_joined,through: :joins, source: :event

  email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }
  validates :city, :state, :first_name, :last_name, presence:true
  validates :first_name,length:{minimum:2, message:"must be at least 2 characters"}
  validates :last_name,length:{minimum:2, message:"must be at least 2 characters"}
  # validate :password_confirmation_matches_password

  # private
  # def password_confirmation_matches_passwosrd
  #   if password != password_confirmation
  #     errors.add(:password_confirmation, " and password must match")
  #   end
  # end
end
