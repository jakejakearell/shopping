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

end
