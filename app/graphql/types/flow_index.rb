class Types::FlowIndex < Types::BaseObject
  field :count, Int,           null: true,  description: '件数'
  field :items, [Types::Flow], null: false, description: '対象データレコードの配列'

  def count
    object[:data].count
  end

  def items
    object[:data].offset(object[:params][:limit] * (object[:params][:page] - 1)).
                  limit(object[:params][:limit])
  end
end
