class Formatter
  def initialize original_value
    @original_value = original_value
    @expected_size = 13;
  end

  def format?
    !(@original_value.size == @expected_size)
  end

  def formatted_value
    if format?
      if @original_value.size == 12
        return @original_value.insert(8, "-")
      end
    end

    return @original_value
  end
end