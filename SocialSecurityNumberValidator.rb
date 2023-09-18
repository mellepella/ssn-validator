require_relative "Formatter"
require_relative "luhn_algorithm"
require 'date'

class SocialSecurityNumberValidator 
  def initialize social_security_number
    #TODO: CHANGE FORMAT TO: YYMMDD, YYYY DOES NOT WORK WHEN CALCULATING THE CONTROL NUMBER

    # My thought process is that to have a united format that I validate,
    # and if the original string is not that format I will try to convert it.
    # I do this to only have to validate one format, while making how you write
    # it pretty irrelevant and flexible, without having to validate 4-5
    # different formats and making the code cluttered/hard to debug and understand
    # The format I chose to go with is: YYYYMMDD-XXXX.
    @formatter = Formatter.new social_security_number
    @social_security_number = @formatter.formatted_value
    @expected_size = 13;
    @expected_legacy_size = 12;
    @legacy_format_start_date = Date.new(1947, 1, 1)
    @legacy_format_end_date = Date.new(1967, 1, 1)
  end

  def get_birth_year
    @social_security_number[0..3].to_i
  end

  def get_birth_month
    @social_security_number[4..5].to_i
  end

  def get_birth_day
    @social_security_number[6..7].to_i
  end

  def get_birth_date
    year = get_birth_year
    month = get_birth_month
    day = get_birth_day

    birth_date = Date.parse("#{year}-#{month}-#{day}")
  end

  def get_ssn_for_control_number_calculations
    @social_security_number[2..(@expected_size - 2)]
  end

  # The control number is based on the sum of the Luhn algorithm.
  def get_control_number
    # Make sure we do not include the control number itself
    number_without_control_number = get_ssn_for_control_number_calculations
    luhn_algorithm_sum = luhn_algorithm number_without_control_number

    control_number = luhn_algorithm_sum.ceil(-1) - luhn_algorithm_sum;

    control_number
  end

  def legacy_format?
    birth_year = get_birth_year
    is_after_start_date = birth_year >= @legacy_format_start_date.year
    is_before_end_date = birth_year <= @legacy_format_end_date.year

    is_after_start_date && is_before_end_date
  end

  def correct_size?
    if legacy_format?
      return @social_security_number.size == @expected_legacy_size
    end

    @social_security_number.size == @expected_size
  end

  def valid_birth_date?
    is_valid_date = Date.valid_date? get_birth_year, get_birth_month, get_birth_day

    if !is_valid_date
      return false
    end

    birth_date = get_birth_date
    now = Date.today;
    is_before_now = birth_date <= now
    is_after_start_date = birth_date >= @legacy_format_start_date

    return is_before_now && is_after_start_date;
  end
  
  def valid_control_number?
    control_number = @social_security_number[12].to_i
    control_number == get_control_number
  end

  def valid?
    if legacy_format?
      # The legacy format (between year 1947 - 1967) has no control number,
      # and it should therefore not be validated.
      return correct_size? && valid_birth_date?
    end

    correct_size? && valid_birth_date? && valid_control_number?
  end
end