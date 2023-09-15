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
      case @original_value.size
      when 12
        @original_value.insert(8, "-")
      else
        @original_value
      end
    else
      @original_value
    end
  end
end