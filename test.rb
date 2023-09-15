require_relative 'SwedishSocialSecurityNumberValidator'
require_relative 'Formatter'

def test(name, actual, expected)
  if actual == expected
    puts "[x] Test '#{name}' passed."

  else
    puts "[ ] FAIL: Test '#{name}' failed. Expected: '#{expected}', got: '#{actual}'"
  end
end

test1Formatter = Formatter.new "200409177953"
test1Results = test1Formatter.formatted_value
test "it correctly formats a variant without a hyphen", test1Results, "20040917-7953"

test2Formatter = Formatter.new "20040917-7953"
test1Results = test1Formatter.formatted_value
test "it correctly formats a complete variant with a hyphen", test1Results, "20040917-7953"

=begin
test2Validator = SwedishSocialSecurityNumberValidator.new "200409177953"
test2Results = test2Validator.valid?
test "it correctly validates a variant without a hyphen", test2Results, true

test3Validator = SwedishSocialSecurityNumberValidator.new "040917-7953"
test3Results = test3Validator.valid?
test "it correctly validates a short variant with hyphen", test3Results, true

test3Validator = SwedishSocialSecurityNumberValidator.new "0409177953"
test3Results = test3Validator.valid?
test "it correctly validates a short variant without a hyphen", test3Results, true

test4Validator = SwedishSocialSecurityNumberValidator.new "20040917-7953"
test4Results = test4Validator.valid?
test "it correctly validates a complete variant", test4Results, true
=end