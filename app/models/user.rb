# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cognito_id :string           not null
#
# Indexes
#
#  index_users_on_cognito_id_and_deleted_at  (cognito_id,deleted_at) UNIQUE
#  index_users_on_created_at                 (created_at)
#  index_users_on_updated_at                 (updated_at)
#
class User < ApplicationRecord
  self.table_name = "users"

  has_one :profile, class_name: 'User::Profile'

  has_many :client_users
  has_many :clients, through: :client_users
end
