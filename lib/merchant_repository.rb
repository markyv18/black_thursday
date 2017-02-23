require_relative "merchant"

class MerchantRepository
  attr_reader :repository

  def initialize(item_csv, parent)
    @item_csv = item_csv
    @parent = parent
  end

  def make_merchant_repository
    @repository = {}
    @item_csv.read.each do |item|
      @repository[item[:id]] = Item.new(item, self)
    end
    return self
  end

end
