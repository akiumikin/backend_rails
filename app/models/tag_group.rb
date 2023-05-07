# == Schema Information
#
# Table name: tag_groups
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
#  index_tag_groups_on_client_id  (client_id)
#
class TagGroup < ApplicationRecord
  self.table_name = "tag_groups"

  belongs_to :client

  validates :name, presence: true
end
