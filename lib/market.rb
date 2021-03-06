class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory_includes? item
    end
  end

  def sorted_item_list
    sorted_items = @vendors.flat_map do |vendor|
      vendor.inventory.flat_map do |inventory|
        inventory[0].name
      end
    end
    sorted_items.uniq.sort
  end

  def total_inventory
    @vendors.reduce(Hash.new) do |memo, vendor|
      vendor.inventory.each do |item|
        if memo[item[0]].nil?
          memo[item[0]] = {vendors: [],
                          quantity: 0}
        end
        memo[item[0]][:vendors] << vendor.name
        memo[item[0]][:quantity] += item.last
      end
    memo
    end
  end

  def overstocked
  overstocked = []
  total_inventory.each do |item, info|
    if info[:quantity] >= 100 || (info[:vendors].length == 1 && info[:quantity] > 50)
      overstocked << item
    end
  end
  overstocked
  end
end
