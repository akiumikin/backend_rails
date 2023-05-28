# == Schema Information
#
# Table name: flows
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :integer          not null
#
# Indexes
#
#  index_flows_on_client_id  (client_id)
#
class Flow < ApplicationRecord
  self.table_name = "flows"

  has_many :resources
  has_many :steps, class_name: 'Flow::Step'

  validates :name, presence: true
end
