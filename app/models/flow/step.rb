# == Schema Information
#
# Table name: flow_steps
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  name        :string           not null
#  order_index :string           not null
#  status      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  flow_id     :integer          not null
#
# Indexes
#
#  index_flow_steps_on_flow_id  (flow_id)
#
class Flow::Step < ApplicationRecord
  self.table_name = "flow_steps"

  has_many :fields, class_name: 'Flow::Step::Field', foreign_key: 'flow_step_id'

  enum status: { lead: 1, active: 2, complete: 3, ng: 4, stay: 5 }
end
