require_relative "Formatter"
require_relative "luhn_algorithm"
require 'date'

class SocialSecurityNumberValidator 
  def initialize social_security_number
    # My thought process is that to have a united format that I validate,
    # and if the original string is not that format I will try to convert it.
    # I do this to only have to validate one format, while making how you write
    # it pretty irrelevant and flexible, without having to validate 4-5
    # different formats and making the code cluttered/hard to debug and understand
    # The format I chose to go with is: YYYYMMDD-XXXX.
    @formatter = Formatter.new social_security_number
    @social_security_number = @formatter.formatted_value
    @expected_size = 13;
  end

  def get_birth_date
    year = @social_security_number[0..3]
    month = @social_security_number[4..5]
    day = @social_security_number[6..7]

    birth_date = Date.parse("#{year}-#{month}-#{day}")
  end

  # The control number is based on the sum of the Luhn algorithm.
  def get_control_number
    # Make sure we do not include the control number itself
    number_without_control_number = @social_security_number[0..(@expected_size - 2)]
    sum = luhn_algorithm number_without_control_number

    control_number = sum.ceil(-1) - sum;

    return control_number
  end

  def correct_size?
    @social_security_number.size == @expected_size
  end

  def valid_birth_date?
    birth_date = get_birth_date
    now = Date.today;

    return birth_date <= now;
  end
  
  def valid_control_number?
    control_number = Integer(@social_security_number[12])

    control_number == get_control_number
  end

  def valid?
    correct_size? && valid_birth_date? && valid_control_number?
  end
end