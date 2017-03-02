require 'minitest/autorun'
require 'minitest/pride'
require 'pry-state'
require './lib/credit_check'

class CreditCheckTest < Minitest::Test

  def test_it_exists
    assert CreditCheck.new(0)
  end

  def test_it_takes_numbers
    creditcheck = CreditCheck.new(4929735477250543)
    assert creditcheck
  end

  def test_it_returns_valid_boolean
    creditcheck = CreditCheck.new(4929735477250543)
    refute_equal creditcheck.valid, nil
  end

  def test_cardnumber_to_array
    creditcheck = CreditCheck.new(79927398713)
    array = creditcheck.cardnumber_to_a
    assert_equal array, [7,9,9,2,7,3,9,8,7,1,3]
  end

  def test_doubler
    creditcheck = CreditCheck.new(79927398713)
    test = creditcheck.doubler(9)
    assert_equal test, 9
  end

  def test_it_sums
    creditcheck = CreditCheck.new(79927398713)
    sum = creditcheck.sum_it
    assert_equal sum, 70
  end

  def test_checksum
    creditcheck = CreditCheck.new(79927398713)
    creditcheck.checksum
    assert_equal creditcheck.valid, true
  end

  def test_other_numbers
    badnum = CreditCheck.new(5541801923795240)
    goodnum = CreditCheck.new(4024007136512380)
    goodnum.checksum
    badnum.checksum
    assert goodnum.valid
    refute badnum.valid
  end

end