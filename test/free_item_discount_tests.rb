require 'test_helper'

module FreeItemDiscountTests
  def test_less_than_min_quantity_does_not_qualify
    items = [
      Item.new('X', 1)
    ]

    assert !@discount.qualifies?(items: items)
  end

  def test_non_matching_products_does_not_qualify
    items = [
      Item.new('W', 2)
    ]

    assert !@discount.qualifies?(items: items)
  end

  def test_one_product_qualifies
    items = [
      Item.new('X', 2)
    ]

    assert @discount.qualifies?(items: items)
  end

  def test_both_products_qualify
    items = [
      Item.new('X', 1),
      Item.new('Y', 1)
    ]

    assert @discount.qualifies?(items: items)
  end

  def test_free_item_is_nil_when_items_do_not_qualify
    items = [
      Item.new('X', 1)
    ]

    assert_nil @discount.free_item(items: items)
  end

  def test_free_items_returns_item_when_items_qualify
    items = [
      Item.new('X', 1),
      Item.new('Y', 1)
    ]

    expected = Item.new('Z', 1)
    assert_equal @discount.free_item(items: items), expected
  end

  def test_free_items_returns_item_when_items_qualify_multiple_times
    items = [
      Item.new('X', 3),
      Item.new('Y', 2)
    ]

    expected = Item.new('Z', 2)
    assert_equal @discount.free_item(items: items), expected
  end
end

class FunctionalFreeItemDiscountTests < Minitest::Test
  include FreeItemDiscountTests

  def setup
    @discount = FunctionalFreeItemDiscount.new('Z', ['X', 'Y'], 2)
  end
end

class ProceduralFreeItemDiscountTests < Minitest::Test
  include FreeItemDiscountTests

  def setup
    @discount = ProceduralFreeItemDiscount.new('Z', ['X', 'Y'], 2)
  end
end
