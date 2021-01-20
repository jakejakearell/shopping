require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({name: 'Peach', price: "$0.75"})
  end

  def test_it_has_attributes
    assert_instance_of Item, @item
    assert_equal "Tomato", @item.name
    assert_equal 0.5, @item.price
  end

end
