require './test/test_helper.rb'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa,
              :se

 def setup
   @se = SalesEngine.from_csv({
     :items => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     :invoices => "./data/invoices.csv",
     :invoice_items => "./data/invoice_items.csv",
     :transactions => "./data/transactions.csv",
     :customers => "./data/customers.csv"
     })
   @sa = SalesAnalyst.new(se)
 end

  def test_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334113)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 5, sa.golden_items.length
    assert_instance_of Item, sa.golden_items.first
  end

  def test_average_invoices_per_merchant
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 12, sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
  end

  def test_top_days_by_invoice_count
    assert_equal ['Wednesday'], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    assert_equal 29.55, sa.invoice_status(:pending)
  end

  def test_top_revenue_earners
    assert_equal 3, sa.top_revenue_earners(3).count
  end

  def test_merchants_with_pending_invoices
    assert_equal 467, sa.merchants_with_pending_invoices.count
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
  end

  def test_merchants_with_only_one_item
    assert_equal 243, sa.merchants_with_only_one_item.count
    assert_instance_of Merchant, sa.merchants_with_only_one_item[0]
  end

  def test_merchants_with_only_one_item_registered_in_month
    assert_equal 18, sa.merchants_with_only_one_item_registered_in_month('June').count
  end

  def test_revenue_by_merchant
    assert_equal 64725.4, sa.revenue_by_merchant(12334123)
  end

  def test_most_sold_item_for_merchant
    assert_equal 2, sa.most_sold_item_for_merchant(12334123).count
    assert_instance_of Item , sa.most_sold_item_for_merchant(12334123)[1]
  end

  def test_best_item_for_merchant
    assert_equal 263553486, sa.best_item_for_merchant(12334141).id
  end

  def test_it_exists
    assert sa
  end

  def test_it_finds_average_number_items
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_finds_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_selling_more_items
    assert_equal 52, sa.merchants_with_high_item_count.length
  end

  def test_average_price_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334159)
  end

  def test_average_of_averages
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end

  def test_price_standard_dev
    assert_equal 2902.69, sa.price_std_dev
  end

  def test_average_invoice_per_merchant
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_top_merchants
    assert_equal 12, sa.top_merchants_by_invoice_count.length
  end

  def test_average_sales_per_day
    assert_equal 712.14, sa.average_invoices_per_day
  end

  def test_average_sales_per_day_std_dev
    assert_equal 18.07, sa.invoices_per_day_std_dev
  end

  def test_days_by_invoice_count
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_percentage_of_invoices_not_shipped
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_valid_cards
    assert sa.card_valid?(4024007116028704)
    refute sa.card_valid?(4068632349831473)
  end

  def test_find_invalid_transactions
    assert_equal 4488, sa.find_invalid_transactions.length
  end

  def test_find_bad_customers
    assert_equal 841, sa.find_bad_customers.length
  end
end
