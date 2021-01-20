require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/vendor'
require './lib/item'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_has_attributes
    assert_instance_of Vendor, @vendor
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal Hash.new, @vendor.inventory
  end

  def test_it_can_stock
    assert_equal 0, @vendor.check_stock(@item1)
    @vendor.stock(@item1, 30)
    assert_equal 30, @vendor.check_stock(@item1)
    @vendor.stock(@item1, 20)
    assert_equal 50, @vendor.check_stock(@item1)
  end

  def test_it_stores_inventory_as_hash
    @vendor.stock(@item1, 30)
    expected = {@item1 => 30}

    assert_equal expected, @vendor.inventory

    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)

    expected = {@item1 => 55, @item2 => 12}
    assert_equal expected, @vendor.inventory
  end

  def test_potential_revenue
    vendor1 = Vendor.new("paul pizza")
    vendor2 = Vendor.new("yummy sh")
    vendor3 = Vendor.new("Rocky Mountain rotten")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)

    assert_equal 29.75, vendor1.potential_revenue
    assert_equal 345.00, vendor2.potential_revenue
    assert_equal 48.75, vendor3.potential_revenue
  end

  def test_vendor_can_tell_you_if_it_has_item
    vendor1 = Vendor.new("paul pizza")
    vendor2 = Vendor.new("yummy sh")
    vendor3 = Vendor.new("Rocky Mountain rotten")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)

    assert_equal true, vendor1.inventory_includes?(item1)
    assert_equal false, vendor1.inventory_includes?(item4)
  end
end
