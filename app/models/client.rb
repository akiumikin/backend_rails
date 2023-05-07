# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_clients_on_created_at  (created_at)
#  index_clients_on_updated_at  (updated_at)
#
class Client < ApplicationRecord
  self.table_name = "clients"

  has_many :config, class_name: 'Client::Config'
  has_many :resources

  has_many :client_users
  has_many :users, through: :client_users

  validates :name, presence: true
end
