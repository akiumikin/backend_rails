# == Schema Information
#
# Table name: resource_items
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  status      :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :integer          not null
#  step_id     :integer          not null
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
end
