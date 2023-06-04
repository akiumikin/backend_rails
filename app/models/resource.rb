# == Schema Information
#
# Table name: resources
#
#  id                        :bigint           not null, primary key
#  deleted_at                :datetime
#  name                      :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  client_id                 :integer          not null
#  first_parent_resource_id  :integer
#  flow_id                   :integer          not null
#  second_parent_resource_id :integer
#
# Indexes
#
#  index_resources_on_client_id                 (client_id)
#  index_resources_on_client_id_and_deleted_at  (client_id,deleted_at) UNIQUE
#
class Resource < ApplicationRecord
  self.table_name = "resources"

  belongs_to :client
  belongs_to :flow
  belongs_to :first_parent_resource,
             class_name: 'Resource',
             foreign_key: 'first_parent_resource_id',
             optional: true
  belongs_to :second_parent_resource,
             class_name: 'Resource',
             foreign_key: 'second_parent_resource_id',
             optional: true

  has_many :items,  class_name: 'Resource::Item',       foreign_key: 'resource_id'
  has_many :steps,  class_name: 'Resource::Step::Item', foreign_key: 'resource_id'
  has_many :fields, -> { order(order_index: :asc) }, class_name: 'Resource::Field', foreign_key: 'resource_id'

  validates :name, presence: true
end
