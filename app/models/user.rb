class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Authorization
  enum role: { user: 0, admin: 1 }
end
