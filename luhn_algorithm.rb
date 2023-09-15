require_relative "numeric?"

def luhn_algorithm numbers
  sum = 0

  numbers.each_char.with_index do |char, index|
    if char.numeric?
      if index.even?
        multiplied_value = Integer(char) * 2;
        separated_values = multiplied_value.to_s.scan(/./)
        separated_values.each {|num| sum += Integer(num)}
      else 
        sum += Integer(char);
      end
    end
  end

  sum
end