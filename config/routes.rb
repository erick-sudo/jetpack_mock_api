Rails.application.routes.draw do
  # resources :photos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # get "services/rest/:method", to: "photos#index"
  # get "services/rest/:method", to: "photos#index"


  get "/mock/oauth/v1/generate", to: "loans#mock_internal_server_error"

  get "/api/v1/categories", to: "products#categories"
  get "/api/v1/products/category/:category/:count", to: "products#products_by_categories"
  get "/api/v1/products/:productId", to: "products#show_product"
  get "/api/v1/users/cart", to: "products#users_cart"
  get "/api/v1/shipping/addresses", to: "products#search_shipping_addresses"
  get "/api/v1/shipping/addresses/:addressId", to: "products#show_shipping_address"
  get "api/v1/auction/listings", to: "products#active_auction_listings"
  get "api/v1/auction/listings/:auction_listing_id", to: "products#auction_listing"
  get "api/v1/auction/listings/bids/:auction_listing_id", to: "products#auction_listing_bids"
  get "api/v1/spin/items", to: "products#spin_items"

  get "prods", to: "products#all_prods"

  get "/oauth/v1/generate", to: "loans#access_token"
  
  scope "mpesa" do
    post "/stkpush/v1/processrequest", to: "loans#express"
    post "/b2c/v3/paymentrequest", to: "loans#b2c"
    post "c2b", to: "loans#c2b"
    post "b2b", to: "loans#b2b"
  end
end
