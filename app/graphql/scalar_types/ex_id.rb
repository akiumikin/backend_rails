class ScalarTypes::ExId < GraphQL::Schema::Scalar
  description 'ID型'

  def self.coerce_input(value, _context)
    if value.instance_of?(Array)
      value.map(&:to_s)
    else
      [value.to_s]
    end
  end

  def self.coerce_result(value, _context)
    value
  end
end
