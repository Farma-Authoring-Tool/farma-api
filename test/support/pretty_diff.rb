module MiniTestPrettyDiff
  def mu_pp(obj)
    s = obj.is_a?(Hash) || obj.is_a?(Array) ? JSON.pretty_generate(sort_keys(obj)) : obj.inspect
    s = s.encode(Encoding.default_external) if defined? Encoding
    s
  end

  def sort_keys(obj)
    case obj
    when Hash
      obj.sort_by { |key, _| key }.to_h { |key, value| [key, sort_keys(value)] }
    when Array
      obj.map { |item| sort_keys(item) }
    else
      obj
    end
  end
end
