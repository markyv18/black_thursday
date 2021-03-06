class Merchant
attr_reader :id,
            :name,
            :merchant_created_at,
            :merchant_updated_at,
            :parent

  def initialize(merchant, merch_repo_parent = nil)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @merchant_created_at = merchant[:created_at]
    @merchant_updated_at = merchant[:updated_at]
    @parent = merch_repo_parent
  end

  def created_at
    if merchant_created_at.class == String
     Time.parse(merchant_created_at)
   elsif merchant_created_at.class == Time
     merchant_created_at
    end
  end

  def updated_at
    if merchant_updated_at.class == String
      Time.parse(merchant_updated_at)
    elsif merchant_updated_at.class == Time
      merchant_updated_at
    end
  end

  def items
    parent.se_parent.items.find_all_by_merchant_id(id)
  end

  def invoices
    parent.se_parent.invoices.find_all_by_merchant_id(id)
  end

  def customers
    invoices.map! do |invoice|
      invoice.customer
    end.uniq do |customer|
      customer.id
    end
  end

  def creation_month
    month = created_at.month
    case month
    when 1 then 'January'
    when 2 then 'February'
    when 3 then 'March'
    when 4 then 'April'
    when 5 then 'May'
    when 6 then 'June'
    when 7 then 'July'
    when 8 then 'August'
    when 9 then 'September'
    when 10 then 'October'
    when 11 then 'November'
    when 12 then 'December'
    end
  end

end
