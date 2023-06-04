# == Schema Information
#
# Table name: resource_step_items
#
#  id               :bigint           not null, primary key
#  deleted_at       :datetime
#  order_index      :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  flow_step_id     :integer          not null
#  resource_item_id :integer          not null
#
# Indexes
#
#  index_resource_step_items_on_flow_step_id      (flow_step_id)
#  index_resource_step_items_on_order_index       (order_index)
#  index_resource_step_items_on_resource_item_id  (resource_item_id)
#
class Resource::Step::Item < ApplicationRecord
  self.table_name = "resource_step_items"

  belongs_to :origin_step, class_name: 'Flow::Step', foreign_key: 'flow_step_id'

  has_many :values, -> { where(kind: :flow_step) }, class_name: 'Value', foreign_key: 'item_id'
  has_many :steps, class_name: 'Resource::Step::Item', foreign_key: 'resource_item_id'
end
