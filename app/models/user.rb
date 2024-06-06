class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { minimum: 1 }, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
end

# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  email                 :string
#  name                  :string
#  password_digest       :string
#  refresh_token_version :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
