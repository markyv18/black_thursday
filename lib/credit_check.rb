require 'pry'
class CreditCheck

  attr_reader :valid

  def initialize(cardnumber)
    @cardnumber = cardnumber
    @valid = false
  end

  def cardnumber_to_a
    cardnumber_array = @cardnumber.to_s.split('').map do |number|
      number.to_i
    end
    cardnumber_array
  end

  def doubler(number)
    if number > 4
      (number*2) - 9
    else
      number*2
    end
  end

  def sum_it
    sum = 0
    index = 0
    reverse_array = cardnumber_to_a.reverse
    reverse_array.each do |number|
      if index % 2 == 0
        sum += number
      else
        sum += doubler(number)
      end
      index += 1
    end
    sum
  end

  def checksum
    if sum_it % 10 == 0
      @valid = true
    end
    @valid
  end

end