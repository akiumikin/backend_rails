# == Schema Information
#
# Table name: resource_fields
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  input_type  :integer          not null
#  name        :string           not null
#  order_index :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :integer          not null
#
# Indexes
#
#  index_resource_fields_on_order_index                          (order_index)
#  index_resource_fields_on_resource_id                          (resource_id)
#  index_resource_fields_on_resource_id_and_name_and_deleted_at  (resource_id,name,deleted_at) UNIQUE
#
class Resource::Field < ApplicationRecord
  self.table_name = "resource_fields"

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
