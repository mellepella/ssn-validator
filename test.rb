require_relative 'SwedishSocialSecurityNumberValidator'

def test(name, actual, expected)
  if actual == expected
    puts "[x] Test '#{name}' passed."

  else
    puts "[ ] Test '#{name}' failed. Expected: '#{expected}', got: '#{actual}'"
  end
end

test1Validator = SwedishSocialSecurityNumberValidator.new "20040917-7953"
test1Results = test1Validator.valid?
test "it correctly validates a complete variant", test1Results, true

test2Validator = SwedishSocialSecurityNumberValidator.new "200409177953"
test2Results = test2Validator.valid?
test "it correctly validates a variant without a hyphen", test2Results, true

test3Validator = SwedishSocialSecurityNumberValidator.new "040917-7953"
test3Results = test3Validator.valid?
test "it correctly validates a short variant with hyphen", test3Results, true

test3Validator = SwedishSocialSecurityNumberValidator.new "0409177953"
test3Results = test3Validator.valid?
test "it correctly validates a short variant without a hyphen", test3Results, true