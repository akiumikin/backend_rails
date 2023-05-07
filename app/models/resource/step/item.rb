# == Schema Information
#
# Table name: flow_step_items
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  name         :string           not null
#  order_index  :integer          not null
#  status       :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  flow_step_id :integer          not null
#
# Indexes
#
#  index_flow_step_items_on_flow_step_id  (flow_step_id)
#
class Resource::Step::Item < ApplicationRecord
  self.table_name = "flow_step_items"
end
