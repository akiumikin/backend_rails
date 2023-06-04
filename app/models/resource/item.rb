# == Schema Information
#
# Table name: resource_items
#
#  id                                                                                                           :bigint           not null, primary key
#  deleted_at                                                                                                   :datetime
#  status                                                                                                       :integer          not null
#  created_at                                                                                                   :datetime         not null
#  updated_at                                                                                                   :datetime         not null
#  resource_id                                                                                                  :integer          not null
#  step_item_id(実質NULLは許容しないが、関連テーブルと相互にIDが必要となるため、NULLを許容して後から値を入れる) :integer
#
# Indexes
#
#  index_resource_items_on_created_at   (created_at)
#  index_resource_items_on_resource_id  (resource_id)
#  index_resource_items_on_status       (status)
#  index_resource_items_on_updated_at   (updated_at)
#
class Resource::Item < ApplicationRecord
  self.table_name = "resource_items"

  belongs_to :resource
  has_many :steps, class_name: 'Resource::Step::Item', foreign_key: 'resource_item_id'
  has_many :values, -> { where(kind: :resource) }, class_name: 'Value', foreign_key: 'item_id'

  enum status: { lead: 1, active: 2, complete: 3, ng: 4, stay: 5 }
end
