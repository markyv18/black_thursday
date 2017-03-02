require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_repository,
              :merchant_csv,
              :se_parent

  def initialize(csv = nil, se_parent)
    @merchant_csv = CSV.open csv, headers: true, header_converters: :symbol
    @se_parent = se_parent
    @merchant_repository = make_merchant_repository
  end

  def inspect
    "#<#{self.class} #{merchant_repository.size} rows>"
  end

  def make_merchant_repository
    merchant_repository = {}
    merchant_csv.read.each do |merchant|
      merchant_repository[merchant[:id]] = Merchant.new(merchant, self)
    end
    merchant_repository
  end

  def all
    merchant_repository.map do |key, value|
      value
    end
  end

  def find_by_id(id)
    if merchant_repository[id.to_s]
      merchant_repository[id.to_s]
    else
      nil
    end
  end

  def find_by_name(name_search)
    all.find do |merchant|
      merchant.name.downcase == name_search.downcase
    end
  end

  def find_all_by_name(partial)
    all.find_all do |merchant|
      merchant.name.downcase.include?(partial.downcase)
    end
  end
end
