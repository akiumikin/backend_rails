class ScalarTypes::ExInt < GraphQL::Schema::Scalar
  description '数値型'

  def self.coerce_input(value, _context)
    if value.instance_of?(Array)
      value.map(&:to_i)
    else
      [value.to_i]
    end
  end

  def self.coerce_result(value, _context)
    value
  end
end
