require_relative "Formatter"
require_relative "luhn_algorithm"

class SwedishSocialSecurityNumberValidator 
  def initialize social_security_number
    # My thought process is that to have a united format that I validate,
    # and if the original string is not that format I will try to convert it.
    # I do this to only have to validate one format, while making how you write
    # it pretty irrelevant and flexible, without having to validate 4-5
    # different formats and making the code cluttered/hard to debug and understand
    @formatter = Formatter.new social_security_number
    @social_security_number = @formatter.formatted_value
    @expected_size = 13;
  end

  # The control number is based on the Luhn algorithm.
  def get_control_number
    # Make sure we do not include the control number itself
    number_without_control_number = @social_security_number[0..(@expected_size - 2)]
    sum = luhn_algorithm number_without_control_number

    control_number = sum.round(-1) - sum;

    return control_number
  end

  def correct_size?
    @social_security_number.size == @expected_size
  end

  def correct_control_number?
    control_number = Integer(@social_security_number[12])

    if control_number == get_control_number
      return true
    end

    return false
  end

  def valid?
    if !correct_size?
      return false
    end

    if !correct_control_number?
      return false
    end

    return true
  end
end