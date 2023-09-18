require_relative "numeric?"

def luhn_algorithm numbers
  sum = 0

  numbers.each_char.with_index do |char, index|
    char_is_not_numeric = !char.numeric?
    next if char_is_not_numeric

    if index.even?
      multiplied_value = char.to_i * 2;
      separated_values = multiplied_value.to_s.scan(/./)
      separated_values.each {|num| sum += num.to_i}
    else
      sum += char.to_i;
    end
  end

  sum
end