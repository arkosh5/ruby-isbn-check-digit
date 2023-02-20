MULTIPLIERS = [1, 3]

def calculate_isbn13_check_digit(isbn)
  # Convert to string if input is an integer
  isbn = isbn.to_s unless isbn.is_a?(String)

  # Remove any non-digit characters from the ISBN
  isbn = isbn.delete('^0-9')

  # Ensure the ISBN is 12 digits long and contains only digits
  raise ArgumentError, 'Invalid ISBN13: must be 12 digits long' unless isbn.size == 12
  raise ArgumentError, 'Invalid ISBN13: input contains non-digit characters' if isbn.match(/\D/)

  # Multiply each digit alternately by 1 and 3, then sum the result
  sum = 0
  isbn.each_char.with_index do |digit, i|
    multiplier = MULTIPLIERS[i % 2]
    sum += digit.to_i * multiplier
  end

  # Take mod 10 of the sum and subtract from 10
  check_digit = 10 - (sum % 10)

  # If the result is 10, make it 0
  check_digit = check_digit.zero? ? 0 : check_digit

  # Return the complete ISBN13
  "#{isbn}#{check_digit}"
end

print calculate_isbn13_check_digit(97801430072)

calculate_isbn13_check_digit("978014300723")
# Returns "9780143007237"
