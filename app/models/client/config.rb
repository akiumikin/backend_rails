# == Schema Information
#
# Table name: client_configs
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  kind       :integer          not null
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :integer          not null
#
# Indexes
#
#  index_client_configs_on_client_id                 (client_id)
#  index_client_configs_on_client_id_and_deleted_at  (client_id,deleted_at) UNIQUE
#
class Client::Config < ApplicationRecord
  self.table_name = "client_configs"

  enum kind: {
    notification: 1 # slack / email
  }
end
