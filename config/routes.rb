Rails.application.routes.draw do
  # resources :photos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # get "services/rest/:method", to: "photos#index"
  # get "services/rest/:method", to: "photos#index"

  get "/api/v1/categories", to: "products#categories"
  get "/api/v1/products/category/:category/:count", to: "products#products_by_categories"
  get "/api/v1/products/:productId", to: "products#show_product"
  get "/api/v1/users/cart", to: "products#users_cart"
  get "/api/v1/shipping/addresses", to: "products#search_shipping_addresses"
  get "/api/v1/shipping/addresses/:addressId", to: "products#show_shipping_address"
  get "api/v1/auction/listings", to: "products#active_auction_listings"
  get "api/v1/auction/listings/:auction_listing_id", to: "products#auction_listing"
  get "api/v1/auction/listings/bids/:auction_listing_id", to: "products#auction_listing_bids"
end
