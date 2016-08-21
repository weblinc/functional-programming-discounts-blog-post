class ProceduralFreeItemDiscount < FreeItemDiscount

  def free_item(items: [])
    quantity_of_qualifying_items = 0

    items.each do |item|
      if item_qualifies?(item)
        quantity_of_qualifying_items += item.quantity
      end
    end

    if quantity_of_qualifying_items >= quantity_needed_per_discount
      Item.new(
        @free_item_product_id,
        quantity_of_qualifying_items / quantity_needed_per_discount
      )
    else
      nil
    end
  end

  def qualifies?(items: [])
    does_qualify = false
    quantity_of_qualifying_items = 0

    items.each do |item|
      if item_qualifies?(item)
        quantity_of_qualifying_items += item.quantity
      end

      if quantity_of_qualifying_items >= quantity_needed_per_discount
        does_qualify = true
        break
      end
    end

    does_qualify
  end

  private

  def quantity_needed_per_discount
    @quantity
  end
end
