# == Schema Information
#
# Table name: tag_group_items
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tag_group_id :integer          not null
#
# Indexes
#
#  index_tag_group_items_on_tag_group_id  (tag_group_id)
#
class TagGroup::Item < ApplicationRecord
  self.table_name = "tag_group_items"
end
