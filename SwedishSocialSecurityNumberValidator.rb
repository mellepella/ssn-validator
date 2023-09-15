class SwedishSocialSecurityNumberValidator 
  def initialize socialSecurityNumber
    @socialSecurityNumber = socialSecurityNumber
  end

  def correctLength?
    @socialSecurityNumber.length == 13 ||
    @socialSecurityNumber.length == 12 ||
    @socialSecurityNumber.length == 11 ||
    @socialSecurityNumber.length == 10
  end

  def valid?
    correctLength?
  end
end