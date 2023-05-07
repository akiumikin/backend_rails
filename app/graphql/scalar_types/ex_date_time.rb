class ScalarTypes::ExDateTime < GraphQL::Schema::Scalar
  description '日時型'

  def self.coerce_input(value, _context)
    Time.zone.parse(value)
  end

  def self.coerce_result(value, _context)
    value.strftime('%Y-%m-%d %H:%M')
  end
end
