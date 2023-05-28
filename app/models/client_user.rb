# == Schema Information
#
# Table name: client_users
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  role       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_client_users_on_client_id                             (client_id)
#  index_client_users_on_client_id_and_role                    (client_id,role)
#  index_client_users_on_client_id_and_user_id_and_deleted_at  (client_id,user_id,deleted_at) UNIQUE
#  index_client_users_on_user_id                               (user_id)
#
class ClientUser < ApplicationRecord
  self.table_name = "client_users"

  belongs_to :client
  belongs_to :user

  enum role: { admin: 1 }
end
