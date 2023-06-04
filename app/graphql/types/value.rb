class Types::Value < Types::BaseObject
  field :id,      ID,      null: true,  description: 'Value ID'
  field :kind,    String,  null: true,  description: '種別'
  field :version, Integer, null: true,  description: 'バージョン'
  field :value,   String,  null: false, description: '値'
  field :field,   Types::Field,  null: true,  description: 'フィールド情報'

  def field
    case object.kind
    when 'resource'
      resource_field
    when 'flow_step'
      step_field
    end
  end

  def resource_field
    AssociationLoader.for(Value, :resource_field).load(object)
  end

  def step_field
    AssociationLoader.for(Value, :step_field).load(object)
  end
end
