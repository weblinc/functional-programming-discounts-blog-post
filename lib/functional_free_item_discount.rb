class FunctionalFreeItemDiscount < FreeItemDiscount

  def free_item(items: [])
    if qualifies?(items: items)
      Item.new(
        @free_item_product_id,
        discountable_quantity(items)
      )
    else
      nil
    end
  end

  def qualifies?(items: [])
    discountable_quantity(items) > 0
  end

  private

  def discountable_quantity(items)
    number_of_qualifying_items(items) / @quantity
  end

  def number_of_qualifying_items(items)
    qualifying_items(items).sum(&:quantity)
  end

  def qualifying_items(items)
    items.select do |item|
      item_qualifies?(item)
    end
  end

end
