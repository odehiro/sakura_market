json.array!(@foods) do |food|
  json.extract! food, :id, :name, :image, :price, :caption, :display, :order_index
  json.url food_url(food, format: :json)
end
