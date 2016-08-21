class FreeItemDiscount

  # @param free_item_product_id
  #   Product ID for the Free Item
  #
  # @param product_ids
  #   The Product IDs that qualify for the discount
  #
  # @param quantity
  #   The quantity of product_ids that must be in the list of items
  #     in order to qualify for the discount
  #
  def initialize(free_item_product_id, product_ids, quantity)
    @free_item_product_id = free_item_product_id
    @product_ids = product_ids
    @quantity = quantity
  end

  def free_item(items: [])
    raise "#{self.class.to_s} must implement #free_item"
  end

  def qualifies?(items: [])
    raise "#{self.class.to_s} must implement #qualifies?"
  end

  private

  def item_qualifies?(item)
    @product_ids.include?(item.product_id)
  end

end
