class Shipping
  def initialize(items_count)
    @items_count = items_count
  end

  def cost
    if @items_count > 5 then
      return 600 + (@items_count / 5 * 600)
    end

    return 600
  end
end
