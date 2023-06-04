class Types::ClientUserIndex < Types::BaseObject
  field :count, Int,                 null: true,  description: '件数'
  field :items, [Types::ClientUser], null: false, description: '対象データレコードの配列'

  def count
    object[:data].count
  end

  def items
    object[:data].offset(object[:params][:limit] * (object[:params][:page] - 1)).
                  limit(object[:params][:limit])
  end
end
