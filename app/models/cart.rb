# PORO = Plain Rold Ruby Object（不需要繼承Application Record資料庫，東西都存在這裡）
class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def empty?
    @items.empty?
  end

  def add_item(product_id)
    found = @items.find{|item| item.product_id == product_id}

    if found
      found.increment!
    else
      @items << CartItem.new(product_id)
    end
  end
end