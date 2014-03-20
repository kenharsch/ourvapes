json.array!(@product_lists) do |product_list|
  json.extract! product_list, :id
  json.url product_list_url(product_list, format: :json)
end
