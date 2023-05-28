class ScalarTypes::ExTime < GraphQL::Schema::Scalar
  description '時刻型'

  def self.coerce_input(value, _context)
    Time.zone.parse(value)
  end

  def self.coerce_result(value, _context)
    value.strftime('%H:%M')
  end
end
