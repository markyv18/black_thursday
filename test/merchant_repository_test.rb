require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo

  def setup
    merchant_csv =  './test/fixtures/merchants.csv'
    parent = ''
    @merchant_repo = MerchantRepository.new(merchant_csv, parent)
  end

  def test_all_returns_array
    assert_equal Array, merchant_repo.all.class
  end

  def test_returns_all_items_within_array
    assert_equal 475, merchant_repo.all.length
  end

  def test_all_returns_merchant_objects
    assert_equal Merchant, merchant_repo.all[7].class
  end

  def test_find_by_id_nil_for_a_unmatched
    assert_nil merchant_repo.find_by_id(6)
  end

  def test_find_by_id_upon_match
    assert_equal "GoldenRayPress", merchant_repo.find_by_id(12334135).name
  end

  def test_find_by_name_nil_when_no_match
    assert_nil merchant_repo.find_by_name("fake")
  end

  def test_find_by_name_returns_merch_object
    assert_equal 12334135, merchant_repo.find_by_name("GoldenRayPress").id
    assert_equal 12334135, merchant_repo.find_by_name("GOLDENRAYPRESS").id
  end

  def test_find_all_by_name_empty_unmatched
    assert_equal [], merchant_repo.find_all_by_name("fake")
  end

  def test_find_all_by_name_single_match
    assert_equal "GoldenRayPress", merchant_repo.find_all_by_name("Gol")[0].name
  end

  def test_find_all_by_name_multi_match
    assert_equal "Shopin1901", merchant_repo.find_all_by_name("Shop")[0].name
    assert_equal "thepurplepenshop", merchant_repo.find_all_by_name("Shop")[1].name
  end

end
