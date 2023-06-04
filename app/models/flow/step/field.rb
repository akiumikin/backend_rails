# == Schema Information
#
# Table name: flow_step_fields
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  input_type   :integer          not null
#  name         :string           not null
#  order_index  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  flow_step_id :integer          not null
#
# Indexes
#
#  index_flow_step_fields_on_flow_step_id  (flow_step_id)
#  index_flow_step_fields_on_order_index   (order_index)
#
class Flow::Step::Field < ApplicationRecord
  self.table_name = "flow_step_fields"

  belongs_to :step, class_name: 'Flow::Step', foreign_key: 'flow_step_id'

  enum input_type: {
    text:      1,
    text_area: 2,
    integer:   3,
    datetime:  4,
    date:      5,
    time:      6,
    pulldown:  7,
    radio:     8,
    document:  9,
    tag:       10,
  }
end
