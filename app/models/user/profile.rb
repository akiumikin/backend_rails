# == Schema Information
#
# Table name: user_profiles
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  email        :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_user_profiles_on_user_id                 (user_id)
#  index_user_profiles_on_user_id_and_deleted_at  (user_id,deleted_at) UNIQUE
#
class User::Profile < ApplicationRecord
  self.table_name = "user_profiles"
end
