# == Schema Information
#
# Table name: value_tags
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  version    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          not null
#  item_id    :integer          not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_value_tags_on_version_and_field_id  (version,field_id)
#  index_value_tags_on_version_and_item_id   (version,item_id)
#  index_value_tags_on_version_and_tag_id    (version,tag_id)
#
class Relation::ValueTag < ApplicationRecord
  self.table_name = "value_tags"
end
