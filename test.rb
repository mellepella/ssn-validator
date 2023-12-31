require_relative 'SocialSecurityNumberValidator'
require_relative 'Formatter'

def test(name, actual, expected)
  if actual == expected
    puts "[x] Test '#{name}' passed."

  else
    puts "[ ] FAIL: Test '#{name}' failed. Expected: '#{expected}', got: '#{actual}'"
  end
end

test_1_formatter = Formatter.new "200409177953"
test_1_results = test_1_formatter.formatted_value
test "it correctly formats a variant without a hyphen", test_1_results, "20040917-7953"

test_2_formatter = Formatter.new "20040917-7953"
test_2_results = test_2_formatter.formatted_value
test "it correctly formats a complete variant with a hyphen", test_2_results, "20040917-7953"

test_3_validator = SocialSecurityNumberValidator.new "2004091779"
test_3_results = test_3_validator.valid?
test "it correctly recognizes a number that is too short", test_3_results, false

test_4_validator = SocialSecurityNumberValidator.new "200409177955"
test_4_results = test_4_validator.valid?
test "it correctly recognizes an incorrect control number when no hyphen", test_4_results, false

test_5_validator = SocialSecurityNumberValidator.new "20040917-7955"
test_5_results = test_5_validator.valid?
test "it correctly recognizes an incorrect control number when hyphen is present", test_5_results, false

test_6_validator = SocialSecurityNumberValidator.new "20040917-7953"
test_6_results = test_6_validator.valid?
test "it correctly recognizes a correct control number", test_6_results, true

test_7_validator = SocialSecurityNumberValidator.new "200409177953"
test_7_results = test_7_validator.valid?
test "it correctly recognizes a correct control number when no hyphen", test_7_results, true

test_8_validator = SocialSecurityNumberValidator.new "20350917-7956"
test_8_results = test_8_validator.valid?
test "it correctly recognizes a date that has not yet passed", test_8_results, false

test_9_validator = SocialSecurityNumberValidator.new "20041317-7953"
test_9_results = test_9_validator.valid?
test "it correctly recognizes an invalid month", test_9_results, false

test_10_ralidator = SocialSecurityNumberValidator.new "20040932-7954"
test_10_results = test_10_ralidator.valid?
test "it correctly recognizes an invalid day", test_10_results, false

test_11_validator = SocialSecurityNumberValidator.new "19480917-795"
test_11_results = test_11_validator.valid?
test "it correctly recognizes a valid legacy social security number", test_11_results, true

test_12_validator = SocialSecurityNumberValidator.new "19480917795"
test_12_results = test_12_validator.valid?
test "it correctly recognizes a legacy social security number without a hyphen", test_12_results, true

test_13_validator = SocialSecurityNumberValidator.new "19880917-795"
test_13_results = test_13_validator.valid?
test "it invalidates a non-legacy social security number without a control number", test_13_results, false

test_14_validator = SocialSecurityNumberValidator.new "19480917-7953"
test_14_results = test_14_validator.valid?
test "it invalidates a legacy social security number with a control number", test_14_results, false

test_15_validator = SocialSecurityNumberValidator.new "20040917-7953"
test_15_results = test_15_validator.valid?
test "it correctly validates a valid social security number", test_15_results, true

test_16_validator = SocialSecurityNumberValidator.new "19940611-6674"
test_16_results = test_16_validator.valid?
test "it correctly validates a valid social security number before the 2000s", test_16_results, true

# Just some abuse testing to make sure nothing has been missed
valid_ssn = ["201603196484", "197003015265", "19960204-4332", "198510096889"]
valid_ssn.each.with_index do |ssn, index|
  validator = SocialSecurityNumberValidator.new ssn
  results = validator.valid?
  test "it correctly validates valid values (#{index + 1}/#{valid_ssn.size})", results, true
end

invalid_ssn = ["202503196489", "193303015265", "1996020434332", "19851090-6889"]
invalid_ssn.each.with_index do |ssn, index|
  validator = SocialSecurityNumberValidator.new ssn
  results = validator.valid?
  test "it correctly invalidates invalid values (#{index + 1}/#{invalid_ssn.size})", results, false
end