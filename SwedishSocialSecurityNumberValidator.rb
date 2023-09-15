class SwedishSocialSecurityNumberValidator 
  def initialize(socialSecurityNumber)
    @socialSecurityNumber = socialSecurityNumber
  end
end

validator = SwedishSocialSecurityNumberValidator.new("20040917-7953")