class User < ApplicationRecord

  #validates :first_name, presence: true
  #validates :last_name, presence: true
  #validates :username, presence: true

  #Authentication
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Authorization
  enum role: { user: 0, admin: 1 }

end
