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
      vendor.inventory.include? item
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
end
