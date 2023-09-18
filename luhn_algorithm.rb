def luhn_algorithm numbers
  sum = 0
  filtered_numbers = numbers.tr('^0-9', '')

  filtered_numbers.each_char.with_index do |char, index|
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