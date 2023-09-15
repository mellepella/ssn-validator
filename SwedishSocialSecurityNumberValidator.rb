require_relative "Formatter"

class SwedishSocialSecurityNumberValidator 
  def initialize social_security_number
    @social_security_number = social_security_number
    @formatter = Formatter.new()
  end

  def valid?
    # My thought process is that to have a united format that I validate,
    # and if the original string is not that format I will try to convert it.
    # I do this to only have to validate one format, while making how you write
    # it pretty irrelevant and flexible, without having to validate 4-5
    # different formats and making the code cluttered/hard to debug and understand

    formatted_value = @formatter.formatted_value
  end
end