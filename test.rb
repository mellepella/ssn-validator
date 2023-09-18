require_relative 'SocialSecurityNumberValidator'
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

test3Validator = SocialSecurityNumberValidator.new "2004091779"
test3Results = test3Validator.valid?
test "it correctly recognizes a number that is too short", test3Results, false

test4Validator = SocialSecurityNumberValidator.new "200409177955"
test4Results = test4Validator.valid?
test "it correctly recognizes an incorrect control number when no hyphen", test4Results, false

test5Validator = SocialSecurityNumberValidator.new "20040917-7955"
test5Results = test5Validator.valid?
test "it correctly recognizes an incorrect control number when hyphen is present", test5Results, false

test6Validator = SocialSecurityNumberValidator.new "20040917-7953"
test6Results = test6Validator.valid?
test "it correctly recognizes a correct control number", test6Results, true

test7Validator = SocialSecurityNumberValidator.new "200409177953"
test7Results = test7Validator.valid?
test "it correctly recognizes a correct control number when no hyphen", test7Results, true

test8Validator = SocialSecurityNumberValidator.new "20350917-7956"
test8Results = test8Validator.valid?
test "it correctly recognizes a date that has not yet passed", test8Results, false

test9Validator = SocialSecurityNumberValidator.new "20041317-7953"
test9Results = test9Validator.valid?
test "it correctly recognizes an invalid month", test9Results, false

test10Validator = SocialSecurityNumberValidator.new "20040932-7954"
test10Results = test10Validator.valid?
test "it correctly recognizes an invalid day", test10Results, false

test11Validator = SocialSecurityNumberValidator.new "19480917-795"
test11Results = test11Validator.valid?
test "it correctly recognizes a valid legacy social security number", test11Results, true

test12Validator = SocialSecurityNumberValidator.new "19480917795"
test12Results = test12Validator.valid?
test "it correctly recognizes a legacy social security number without a hyphen", test12Results, true

test13Validator = SocialSecurityNumberValidator.new "19880917-795"
test13Results = test13Validator.valid?
test "it invalidates a non-legacy social security number without a control number", test13Results, false