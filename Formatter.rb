class Formatter
  def initialize original_value
    @original_value = original_value
    @expected_size = 13;
    @expected_legacy_size = 12;
    @legacy_format_start_date = Date.new(1947, 1, 1)
    @legacy_format_end_date = Date.new(1967, 1, 1)
  end

  def get_birth_year
    @original_value[0..3].to_i
  end

  def legacy_format?
    birth_year = get_birth_year
    birth_year >= @legacy_format_start_date.year && birth_year <= @legacy_format_end_date.year
  end

  def format?
    if legacy_format?
      is_correct_size = @original_value.size == @expected_legacy_size
      return !is_correct_size
    end

    is_correct_size = @original_value.size == @expected_size
    !(is_correct_size)
  end

  def formatted_value
    should_not_format = !format?
    return @original_value if should_not_format

    # For the "standard" format when no hyphen. (YYYYMMDDXXXX)
    if @original_value.size == 12
      return @original_value.insert(8, "-")

    # Between the years 1947 and 1967 no control number was present,
    # therefore this application must also accept social security numbers
    # without a control number, and with no hyphen. (YYYYMMDD-XXX)
    elsif @original_value.size == 11
      return @original_value.insert(8, "-")

    else return @original_value
    end
  end
end