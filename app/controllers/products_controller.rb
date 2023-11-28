require 'faker'

class ProductsController < ApplicationController

    def cats
        [
            {
                "name"=>"Electronics",
                "description"=> "Explore a wide range of electronic gadgets and devices."
            },
            {
                "name"=>"Clothing",
                "description"=> "Shop for stylish clothing for all occasions."
            },
            {
                "name"=>"Home & Furniture",
                "description"=> "Furnish your home with stylish and functional furniture."
            },
            {
                "name"=>"Books",
                "description"=> "Explore a vast collection of books for every reader."
            },
            {
                "name"=>"Sports & Outdoors",
                "description"=> "Stay active and enjoy the great outdoors with our sports gear."
            },
            {
                "name"=>"Beauty & Personal Care",
                "description"=> "Enhance your beauty and take care of yourself with our products."
            },
            {
                "name"=>"Toys & Games",
                "description"=> "Explore a world of fun and entertainment with our toys and games."
            },
            {
                "name"=>"Automotive",
                "description"=> "Upgrade your vehicle with our automotive parts and accessories."
            },
            {
                "name"=>"Health & Wellness",
                "description"=> "Prioritize your health and well-being with our wellness products."
            },
            {
                "name"=>"Jewelry & Watches",
                "description"=> "Adorn yourself with elegant jewelry and stylish watches."
            },
            {
                "name"=>"Home Appliances",
                "description"=> "Upgrade your home with modern and efficient appliances."
            },
            {
                "name"=>"Pet Supplies",
                "description"=> "Find everything you need to care for your beloved pets."
            },
            {
                "name"=>"Office & Stationery",
                "description"=> "Equip your workspace with essential office supplies and stationery."
            },
            {
                "name"=>"Travel & Luggage",
                "description"=> "Travel in style and convenience with our luggage and accessories."
            },
            {
                "name"=>"Home Improvement",
                "description"=> "Upgrade and beautify your home with our improvement products."
            },
            {
                "name"=>"Gourmet Food & Drinks",
                "description"=> "Indulge in gourmet delights and fine beverages."
            }
        ]
    end

    def categories
        render json: {
            "categories" => cats
        }
    end

    def products_by_categories
        category = params[:category]
        count = params[:count].to_i
        prods = (1..count).to_a.map do
            prod = ["name", "description"].reduce({ "category" => category }) do |acc2, curr2|
                acc2[curr2] = Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0]
                acc2
            end
            prod["id"] = fakeUUID()
            prod["price"] = rand(500.45..12000.76).to_f
            prod["thumbnail"] = thumbnail_url()
            prod
        end

        render json: {
            "products": prods
        }
    end

    def show_product
        prod = { "category" => cats.sample["name"] }

        prod["id"] = fakeUUID()
        prod["name"] = Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0]
        prod["description"] = Faker::Lorem.paragraph sentence_count: rand(7..10)
        prod["price"] = rand(500.45..12000.76).to_f
        prod["thumbnails"] = (1..rand(1..7)).to_a.map { thumbnail_url() }
        prod["attributes"] = (1..rand(5..8)).to_a.map { Faker::Lorem.words.join(" ") }.reduce({}) do |acc3, curr3|
            acc3[curr3] = Faker::Lorem.paragraph sentence_count: rand(1..10)
            acc3
        end

        render json: prod
    end

    def users_cart
        render json: {
            "cart_items" => (1..rand(4..5)).to_a.map do
                { 
                    "product_id" => fakeUUID(), 
                    "product_name" => Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0], 
                    "thumbnail" => thumbnail_url(),
                    "cart_id" => fakeUUID() , 
                    "quantity" => 1, 
                    "price" => rand(544.45..12000.34), 
                    "status" => false 
                } 
            end
        }
    end

    def search_shipping_addresses
        addresses = (1..rand(3..8)).map do
            {
                id: fakeUUID(),
                name: Faker::Address.street_name,
                country: Faker::Address.country.split(" ")[0],
                county: Faker::Address.street_name.split(" ")[0],
                sub_county: Faker::Address.street_name.split(" ")[0],
                street_address: Faker::Address.street_address,
                street_address2: Faker::Address.secondary_address
            }
        end
        render json: {
            "shipping_addresses" => addresses
        }
    end

    def show_shipping_address
        render json: {
            id: fakeUUID(),
            name: Faker::Address.street_name,
            country: Faker::Address.country.split(" ")[0],
            county: Faker::Address.street_name.split(" ")[0],
            sub_county: Faker::Address.street_name.split(" ")[0],
            street_address: Faker::Address.street_address,
            street_address2: Faker::Address.secondary_address
        }
    end

    def active_auction_listings
        auction_listings = (5..rand(6..10)).to_a.map do
            {
                "id" => fakeUUID(),
                "product_id" => fakeUUID(),
                "thumbnail" => thumbnail_url(),
                "product_name" => Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0],
                "thresh_hold" => rand(500.45..12000.76).to_f,
                "starting_bid" => rand(500.45..1000.76).to_f,
                "current_bid" => rand(10000.45..12000.76).to_f,
                "created_at" => rand(1700574371088..1700834123693)
            }
        end
        render json: auction_listings
    end

    def auction_listing
        auction_listing_id = params[:auction_listing_id]
        render json: {
            "id" => auction_listing_id,
            "product_id" => fakeUUID(),
            "thumbnail" => thumbnail_url(),
            "product_name" => Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0],
            "thresh_hold" => rand(500.45..12000.76).to_f,
            "starting_bid" => rand(500.45..1000.76).to_f,
            "current_bid" => rand(10000.45..12000.76).to_f,
            "created_at" => rand(1700574371088..1700834123693)
        }
    end

    def auction_listing_bids
        auction_listing_id = params[:auction_listing_id]
        bids = (1..rand(8..23)).to_a.map do
            {
                "id" => auction_listing_id,
                "bidder" => Faker::Name.name,
                "bidder_id" => fakeUUID(),
                "auction_id" => fakeUUID,
                "bid_amount" => rand(50.45..2000.04),
                "placed_at" => rand(1700574371088..1700834123693)
            }
        end

        render json: bids
    end

    private

    def product_thumbnails
        ["l1.png",
        "l2.png",
        "l3.png",
        "l4.jpeg",
        "l5.png",
        "l6.png",
        "l7.png"]
    end

    def thumbnail_url
        "http://10.0.2.2:3000/#{product_thumbnails().sample}"
    end

    def fakeUUID()
        "#{Random.srand()}".slice(0, 36)
    end
end
