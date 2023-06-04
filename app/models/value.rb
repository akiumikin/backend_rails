# == Schema Information
#
# Table name: values
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  kind       :integer          not null
#  value      :string           not null
#  version    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          not null
#  item_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_values_on_kind_and_field_id  (kind,field_id)
#  index_values_on_kind_and_item_id   (kind,item_id)
#  index_values_on_kind_and_user_id   (kind,user_id)
#
class Value < ApplicationRecord
  self.table_name = "values"

  belongs_to :user
  belongs_to :resource_field, class_name: 'Resource::Field', foreign_key: 'field_id', optional: true
  def resource_field
    return unless kind == 'resource'

    super
  end
  belongs_to :step_field, class_name: 'Flow::Step::Field', foreign_key: 'field_id', optional: true
  def step_field
    return unless kind == 'flow_step'

    super
  end

  validates :kind,    presence: true
  validates :version, presence: true

  enum kind: { resource: 1, flow_step: 2 }

  def self.field
  end

  def self.item
  end
end
