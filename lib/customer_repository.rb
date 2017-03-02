require_relative 'customer'

class CustomerRepository
  attr_reader :parent,
              :repository,
              :customer_csv

  def initialize(csv, parent)
    @customer_csv = CSV.open csv, headers: true, header_converters: :symbol
    @parent = parent
    @repository = make_repository
  end

  def inspect
    "#<#{self.class} #{repository.size} rows>"
  end

  def make_repository
    repository = {}
    customer_csv.read.each do |customer|
      repository[customer[:id]] = Customer.new(customer, self)
    end
    repository
  end

  def all
    repository.map do  |key, value|
      value
    end
  end

  def find_by_id(id)
    if repository[id.to_s]
      repository[id.to_s]
    else
      nil
    end
  end

  def find_all_by_first_name(first_name)
    all.find_all do |transaction|
      transaction.first_name.downcase.include? first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |transaction|
      transaction.last_name.downcase.include? last_name.downcase
    end
  end
end
