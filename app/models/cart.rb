# PORO = Plain Rold Ruby Object（不需要繼承Application Record資料庫，東西都存在這裡）
class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
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

  def total_price
    # total = 0
    # @items.each do |item|
    #   total += item.total_price
    # end
    # total

    total_price = @items.reduce(0) { |sum, item| sum + item.total_price }

    if Time.now.to_date == Date.parse('Dec 25')
      total_price * 0.9
    else
      total_price
    end
  end

  def serialize
    items = @items.map { |item| { "product_id" => item.product_id, "quantity" => item.quantity } }
    { "items" => items }
  end

  def self.from_hash(hash = nil)
    # {
    #   "items" => [
    #     { "product_id" => 1, "quantity" => 3 },
    #     { "product_id" => 2, "quantity" => 2 }
    #   ]
    # }

    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end

  end
end