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

test3Validator = SwedishSocialSecurityNumberValidator.new "2004091779"
test3Results = test3Validator.valid?
test "it correctly recognizes a number that is too short", test3Results, false

test4Validator = SwedishSocialSecurityNumberValidator.new "200409177955"
test4Results = test4Validator.valid?
test "it correctly recognizes an incorrect control number when no hyphen", test4Results, false

test5Validator = SwedishSocialSecurityNumberValidator.new "20040917-7955"
test5Results = test5Validator.valid?
test "it correctly recognizes an incorrect control number when hyphen is present", test5Results, false

test6Validator = SwedishSocialSecurityNumberValidator.new "20040917-7953"
test6Results = test6Validator.valid?
test "it correctly recognizes a correct control number", test6Results, true