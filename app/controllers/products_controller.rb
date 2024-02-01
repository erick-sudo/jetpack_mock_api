require 'faker'

class ProductsController < ApplicationController

    def all_prods
        render json: prods()
    end

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

        [
            {"name"=>"men's clothing", "description"=>"Description"},
            {"name"=>"jewelery", "description"=>"Description"},
            {"name"=>"electronics", "description"=>"Description"},
            {"name"=>"women's clothing", "description"=>"Description"}
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
        prds = prods().filter { |p| p["category"] == category}.shuffle.slice(0..(count-1))
        # .to_a.map do
        #     prod = ["name", "description"].reduce({ "category" => category }) do |acc2, curr2|
        #         acc2[curr2] = Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0]
        #         acc2
        #     end
        #     prod["id"] = fakeUUID()
        #     prod["price"] = rand(500.45..12000.76).to_f
        #     prod["thumbnail"] = thumbnail_url()
        #     prod
        # end

        render json: {
            "products": prds&.map do |p|
                p["thumbnail"] = thumbnail_url(p["thumbnail"])
                p
            end
        }
    end

    def show_product
        prod = find_product(params[:productId])

        # prod["id"] = fakeUUID()
        # prod["name"] = Faker::Lorem.sentence(word_count: rand(1..3)).split(".")[0]
        # prod["description"] = Faker::Lorem.paragraph sentence_count: rand(7..10)
        # prod["price"] = rand(500.45..12000.76).to_f
        prod["thumbnails"] = (1..rand(4..7)).to_a.map { thumbnail_url(prod["thumbnail"]) }
        prod["attributes"] = (1..rand(5..8)).to_a.map { Faker::Lorem.words.join(" ") }.reduce({}) do |acc3, curr3|
            acc3[curr3] = Faker::Lorem.paragraph sentence_count: rand(1..10)
            acc3
        end

        prod.delete "thumbnail"

        render json: prod
    end

    def users_cart
        render json: {
            "cart_items" => (1..rand(4..5)).to_a.map do
                prod = prods().sample
                { 
                    "product_id" => prod["id"], 
                    "product_name" => prod["name"], 
                    "thumbnail" => thumbnail_url(prod["thumbnail"]),
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
            prod = prods().sample
            {
                "id" => prod["id"],
                "product_id" => prod["id"],
                "thumbnail" => thumbnail_url(prod["thumbnail"]),
                "product_name" => prod["name"],
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
        prod = find_product(auction_listing_id)
        render json: {
            "id" => auction_listing_id,
            "product_id" => prod["id"],
            "thumbnail" => thumbnail_url(prod["thumbnail"]),
            "product_name" => prod["name"],
            "thresh_hold" => rand(500.45..12000.76).to_f,
            "starting_bid" => rand(500.45..1000.76).to_f,
            "current_bid" => rand(10000.45..12000.76).to_f,
            "created_at" => rand(1700574371088..1700834123693)
        }
    end

    def auction_listing_bids
        auction_listing_id = params[:auction_listing_id]
        prod = find_product(auction_listing_id)
        bids = (1..rand(8..23)).to_a.map do
            {
                "id" => fakeUUID(),
                "bidder" => Faker::Name.name,
                "bidder_id" => fakeUUID(),
                "auction_id" => prod["id"],
                "bid_amount" => rand(50.45..2000.04),
                "placed_at" => rand(1700574371088..1700834123693)
            }
        end

        render json: bids
    end

    def spin_items
        items = (1..rand(4..8)).to_a.map do
            prod = prods().sample
            {
                "product_id" => fakeUUID(),
                "thumbnail" => thumbnail_url(prod["thumbnail"])
            }
        end
        render json: items
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

    def find_product(id)
        prods().find { |p| p["id"] == id }
    end

    def thumbnail_url(path)
        # "http://10.0.2.2:3000/#{product_thumbnails().sample}"
        "http://10.0.2.2:3000#{path}"
    end

    def fakeUUID()
        "#{Random.srand()}".slice(0, 36)
    end

    def prods
        [
            {
                "id" => "1",
                "name" => "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                "price" => 109.95,
                "description" => "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                "category" => "men's clothing",
                "thumbnail" => "/81fPKd-2AYL._AC_SL1500_.jpg",
                "rating" => {
                    "rate" => 3.9,
                    "count" => 120
                },
                "thumbnails" => [
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg"
                ]
            },
            {
                "id" => "2",
                "name" => "Mens Casual Premium Slim Fit T-Shirts ",
                "price" => 22.3,
                "description" => "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                "category" => "men's clothing",
                "thumbnail" => "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                "rating" => {
                    "rate" => 4.1,
                    "count" => 259
                },
                "thumbnails" => [
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
                ]
            },
            {
                "id" => "3",
                "name" => "Mens Cotton Jacket",
                "price" => 55.99,
                "description" => "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
                "category" => "men's clothing",
                "thumbnail" => "/71li-ujtlUL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 4.7,
                    "count" => 500
                },
                "thumbnails" => [
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "4",
                "name" => "Mens Casual Slim Fit",
                "price" => 15.99,
                "description" => "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.",
                "category" => "men's clothing",
                "thumbnail" => "/71YXzeOuslL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 2.1,
                    "count" => 430
                },
                "thumbnails" => [
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "5",
                "name" => "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
                "price" => 695,
                "description" => "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
                "category" => "jewelery",
                "thumbnail" => "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 4.6,
                    "count" => 400
                },
                "thumbnails" => [
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "6",
                "name" => "Solid Gold Petite Micropave ",
                "price" => 168,
                "description" => "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
                "category" => "jewelery",
                "thumbnail" => "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 3.9,
                    "count" => 70
                },
                "thumbnails" => [
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "7",
                "name" => "White Gold Plated Princess",
                "price" => 9.99,
                "description" => "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
                "category" => "jewelery",
                "thumbnail" => "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 3,
                    "count" => 400
                },
                "thumbnails" => [
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "8",
                "name" => "Pierced Owl Rose Gold Plated Stainless Steel Double",
                "price" => 10.99,
                "description" => "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
                "category" => "jewelery",
                "thumbnail" => "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 1.9,
                    "count" => 100
                },
                "thumbnails" => [
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "9",
                "name" => "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
                "price" => 64,
                "description" => "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
                "category" => "electronics",
                "thumbnail" => "/61IBBVJvSDL._AC_SY879_.jpg",
                "rating" => {
                    "rate" => 3.3,
                    "count" => 203
                },
                "thumbnails" => [
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg"
                ]
            },
            {
                "id" => "10",
                "name" => "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
                "price" => 109,
                "description" => "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
                "category" => "electronics",
                "thumbnail" => "/61U7T1koQqL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 470
                },
                "thumbnails" => [
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "11",
                "name" => "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
                "price" => 109,
                "description" => "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.",
                "category" => "electronics",
                "thumbnail" => "/71kWymZ+c+L._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 4.8,
                    "count" => 319
                },
                "thumbnails" => [
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "12",
                "name" => "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                "price" => 114,
                "description" => "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty",
                "category" => "electronics",
                "thumbnail" => "/61mtL65D4cL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 4.8,
                    "count" => 400
                },
                "thumbnails" => [
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "13",
                "name" => "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
                "price" => 599,
                "description" => "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate => 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16 => 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz",
                "category" => "electronics",
                "thumbnail" => "/81QpkIctqPL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 250
                },
                "thumbnails" => [
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "14",
                "name" => "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED ",
                "price" => 999.99,
                "description" => "49 INCH SUPER ULTRAWIDE 32 =>9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
                "category" => "electronics",
                "thumbnail" => "/81Zt42ioCgL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.2,
                    "count" => 140
                },
                "thumbnails" => [
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "15",
                "name" => "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
                "price" => 56.99,
                "description" => "Note =>The Jackets is US standard size, Please choose size as your usual wear Material => 100% Polyester; Detachable Liner Fabric => Warm Fleece. Detachable Functional Liner => Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets => 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design => Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates",
                "category" => "women's clothing",
                "thumbnail" => "/51Y5NI-I5jL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 2.6,
                    "count" => 235
                },
                "thumbnails" => [
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "16",
                "name" => "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
                "price" => 29.95,
                "description" => "100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON",
                "category" => "women's clothing",
                "thumbnail" => "/81XH0e8fefL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 340
                },
                "thumbnails" => [
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "17",
                "name" => "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
                "price" => 39.99,
                "description" => "Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.",
                "category" => "women's clothing",
                "thumbnail" => "/71HblAHs5xL._AC_UY879_-2.jpg",
                "rating" => {
                    "rate" => 3.8,
                    "count" => 679
                },
                "thumbnails" => [
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg"
                ]
            },
            {
                "id" => "18",
                "name" => "MBJ Women's Solid Short Sleeve Boat Neck V ",
                "price" => 9.85,
                "description" => "95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem",
                "category" => "women's clothing",
                "thumbnail" => "/71z3kpMAYsL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 4.7,
                    "count" => 130
                },
                "thumbnails" => [
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "19",
                "name" => "Opna Women's Short Sleeve Moisture",
                "price" => 7.95,
                "description" => "100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort",
                "category" => "women's clothing",
                "thumbnail" => "/51eg55uWmdL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 4.5,
                    "count" => 146
                },
                "thumbnails" => [
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "20",
                "name" => "DANVOUY Womens T Shirt Casual Cotton Short",
                "price" => 12.99,
                "description" => "95%Cotton,5%Spandex, Features => Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion => Casual/Office/Beach/School/Home/Street. Season => Spring,Summer,Autumn,Winter.",
                "category" => "women's clothing",
                "thumbnail" => "/61pHAEJ4NML._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 3.6,
                    "count" => 145
                },
                "thumbnails" => [
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "21",
                "name" => "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                "price" => 109.95,
                "description" => "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                "category" => "men's clothing",
                "thumbnail" => "/81fPKd-2AYL._AC_SL1500_.jpg",
                "rating" => {
                    "rate" => 3.9,
                    "count" => 120
                },
                "thumbnails" => [
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg"
                ]
            },
            {
                "id" => "22",
                "name" => "Mens Casual Premium Slim Fit T-Shirts ",
                "price" => 22.3,
                "description" => "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                "category" => "men's clothing",
                "thumbnail" => "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                "rating" => {
                    "rate" => 4.1,
                    "count" => 259
                },
                "thumbnails" => [
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
                ]
            },
            {
                "id" => "23",
                "name" => "Mens Cotton Jacket",
                "price" => 55.99,
                "description" => "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
                "category" => "men's clothing",
                "thumbnail" => "/71li-ujtlUL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 4.7,
                    "count" => 500
                },
                "thumbnails" => [
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "24",
                "name" => "Mens Casual Slim Fit",
                "price" => 15.99,
                "description" => "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.",
                "category" => "men's clothing",
                "thumbnail" => "/71YXzeOuslL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 2.1,
                    "count" => 430
                },
                "thumbnails" => [
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "25",
                "name" => "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
                "price" => 695,
                "description" => "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
                "category" => "jewelery",
                "thumbnail" => "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 4.6,
                    "count" => 400
                },
                "thumbnails" => [
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "26",
                "name" => "Solid Gold Petite Micropave ",
                "price" => 168,
                "description" => "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
                "category" => "jewelery",
                "thumbnail" => "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 3.9,
                    "count" => 70
                },
                "thumbnails" => [
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "27",
                "name" => "White Gold Plated Princess",
                "price" => 9.99,
                "description" => "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
                "category" => "jewelery",
                "thumbnail" => "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 3,
                    "count" => 400
                },
                "thumbnails" => [
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "28",
                "name" => "Pierced Owl Rose Gold Plated Stainless Steel Double",
                "price" => 10.99,
                "description" => "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
                "category" => "jewelery",
                "thumbnail" => "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 1.9,
                    "count" => 100
                },
                "thumbnails" => [
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "29",
                "name" => "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
                "price" => 64,
                "description" => "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
                "category" => "electronics",
                "thumbnail" => "/61IBBVJvSDL._AC_SY879_.jpg",
                "rating" => {
                    "rate" => 3.3,
                    "count" => 203
                },
                "thumbnails" => [
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg"
                ]
            },
            {
                "id" => "30",
                "name" => "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
                "price" => 109,
                "description" => "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
                "category" => "electronics",
                "thumbnail" => "/61U7T1koQqL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 470
                },
                "thumbnails" => [
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "31",
                "name" => "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
                "price" => 109,
                "description" => "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.",
                "category" => "electronics",
                "thumbnail" => "/71kWymZ+c+L._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 4.8,
                    "count" => 319
                },
                "thumbnails" => [
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "32",
                "name" => "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                "price" => 114,
                "description" => "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty",
                "category" => "electronics",
                "thumbnail" => "/61mtL65D4cL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 4.8,
                    "count" => 400
                },
                "thumbnails" => [
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "33",
                "name" => "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
                "price" => 599,
                "description" => "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate => 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16 => 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz",
                "category" => "electronics",
                "thumbnail" => "/81QpkIctqPL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 250
                },
                "thumbnails" => [
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "34",
                "name" => "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED ",
                "price" => 999.99,
                "description" => "49 INCH SUPER ULTRAWIDE 32 =>9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
                "category" => "electronics",
                "thumbnail" => "/81Zt42ioCgL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.2,
                    "count" => 140
                },
                "thumbnails" => [
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "35",
                "name" => "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
                "price" => 56.99,
                "description" => "Note =>The Jackets is US standard size, Please choose size as your usual wear Material => 100% Polyester; Detachable Liner Fabric => Warm Fleece. Detachable Functional Liner => Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets => 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design => Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates",
                "category" => "women's clothing",
                "thumbnail" => "/51Y5NI-I5jL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 2.6,
                    "count" => 235
                },
                "thumbnails" => [
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "36",
                "name" => "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
                "price" => 29.95,
                "description" => "100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON",
                "category" => "women's clothing",
                "thumbnail" => "/81XH0e8fefL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 340
                },
                "thumbnails" => [
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "37",
                "name" => "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
                "price" => 39.99,
                "description" => "Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.",
                "category" => "women's clothing",
                "thumbnail" => "/71HblAHs5xL._AC_UY879_-2.jpg",
                "rating" => {
                    "rate" => 3.8,
                    "count" => 679
                },
                "thumbnails" => [
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg"
                ]
            },
            {
                "id" => "38",
                "name" => "MBJ Women's Solid Short Sleeve Boat Neck V ",
                "price" => 9.85,
                "description" => "95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem",
                "category" => "women's clothing",
                "thumbnail" => "/71z3kpMAYsL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 4.7,
                    "count" => 130
                },
                "thumbnails" => [
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "39",
                "name" => "Opna Women's Short Sleeve Moisture",
                "price" => 7.95,
                "description" => "100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort",
                "category" => "women's clothing",
                "thumbnail" => "/51eg55uWmdL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 4.5,
                    "count" => 146
                },
                "thumbnails" => [
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "40",
                "name" => "DANVOUY Womens T Shirt Casual Cotton Short",
                "price" => 12.99,
                "description" => "95%Cotton,5%Spandex, Features => Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion => Casual/Office/Beach/School/Home/Street. Season => Spring,Summer,Autumn,Winter.",
                "category" => "women's clothing",
                "thumbnail" => "/61pHAEJ4NML._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 3.6,
                    "count" => 145
                },
                "thumbnails" => [
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "41",
                "name" => "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                "price" => 109.95,
                "description" => "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                "category" => "men's clothing",
                "thumbnail" => "/81fPKd-2AYL._AC_SL1500_.jpg",
                "rating" => {
                    "rate" => 3.9,
                    "count" => 120
                },
                "thumbnails" => [
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg",
                    "/81fPKd-2AYL._AC_SL1500_.jpg"
                ]
            },
            {
                "id" => "42",
                "name" => "Mens Casual Premium Slim Fit T-Shirts ",
                "price" => 22.3,
                "description" => "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                "category" => "men's clothing",
                "thumbnail" => "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                "rating" => {
                    "rate" => 4.1,
                    "count" => 259
                },
                "thumbnails" => [
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    "/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
                ]
            },
            {
                "id" => "43",
                "name" => "Mens Cotton Jacket",
                "price" => 55.99,
                "description" => "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
                "category" => "men's clothing",
                "thumbnail" => "/71li-ujtlUL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 4.7,
                    "count" => 500
                },
                "thumbnails" => [
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg",
                    "/71li-ujtlUL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "44",
                "name" => "Mens Casual Slim Fit",
                "price" => 15.99,
                "description" => "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.",
                "category" => "men's clothing",
                "thumbnail" => "/71YXzeOuslL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 2.1,
                    "count" => 430
                },
                "thumbnails" => [
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg",
                    "/71YXzeOuslL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "45",
                "name" => "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
                "price" => 695,
                "description" => "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
                "category" => "jewelery",
                "thumbnail" => "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 4.6,
                    "count" => 400
                },
                "thumbnails" => [
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    "/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "46",
                "name" => "Solid Gold Petite Micropave ",
                "price" => 168,
                "description" => "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
                "category" => "jewelery",
                "thumbnail" => "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 3.9,
                    "count" => 70
                },
                "thumbnails" => [
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    "/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "47",
                "name" => "White Gold Plated Princess",
                "price" => 9.99,
                "description" => "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
                "category" => "jewelery",
                "thumbnail" => "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 3,
                    "count" => 400
                },
                "thumbnails" => [
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    "/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "48",
                "name" => "Pierced Owl Rose Gold Plated Stainless Steel Double",
                "price" => 10.99,
                "description" => "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
                "category" => "jewelery",
                "thumbnail" => "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                "rating" => {
                    "rate" => 1.9,
                    "count" => 100
                },
                "thumbnails" => [
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    "/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg"
                ]
            },
            {
                "id" => "49",
                "name" => "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
                "price" => 64,
                "description" => "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
                "category" => "electronics",
                "thumbnail" => "/61IBBVJvSDL._AC_SY879_.jpg",
                "rating" => {
                    "rate" => 3.3,
                    "count" => 203
                },
                "thumbnails" => [
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg",
                    "/61IBBVJvSDL._AC_SY879_.jpg"
                ]
            },
            {
                "id" => "50",
                "name" => "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
                "price" => 109,
                "description" => "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
                "category" => "electronics",
                "thumbnail" => "/61U7T1koQqL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 470
                },
                "thumbnails" => [
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg",
                    "/61U7T1koQqL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "51",
                "name" => "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
                "price" => 109,
                "description" => "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.",
                "category" => "electronics",
                "thumbnail" => "/71kWymZ+c+L._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 4.8,
                    "count" => 319
                },
                "thumbnails" => [
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg",
                    "/71kWymZ+c+L._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "52",
                "name" => "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                "price" => 114,
                "description" => "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty",
                "category" => "electronics",
                "thumbnail" => "/61mtL65D4cL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 4.8,
                    "count" => 400
                },
                "thumbnails" => [
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg",
                    "/61mtL65D4cL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "53",
                "name" => "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
                "price" => 599,
                "description" => "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate => 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16 => 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz",
                "category" => "electronics",
                "thumbnail" => "/81QpkIctqPL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 250
                },
                "thumbnails" => [
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg",
                    "/81QpkIctqPL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "54",
                "name" => "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED ",
                "price" => 999.99,
                "description" => "49 INCH SUPER ULTRAWIDE 32 =>9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
                "category" => "electronics",
                "thumbnail" => "/81Zt42ioCgL._AC_SX679_.jpg",
                "rating" => {
                    "rate" => 2.2,
                    "count" => 140
                },
                "thumbnails" => [
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg",
                    "/81Zt42ioCgL._AC_SX679_.jpg"
                ]
            },
            {
                "id" => "55",
                "name" => "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
                "price" => 56.99,
                "description" => "Note =>The Jackets is US standard size, Please choose size as your usual wear Material => 100% Polyester; Detachable Liner Fabric => Warm Fleece. Detachable Functional Liner => Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets => 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design => Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates",
                "category" => "women's clothing",
                "thumbnail" => "/51Y5NI-I5jL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 2.6,
                    "count" => 235
                },
                "thumbnails" => [
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg",
                    "/51Y5NI-I5jL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "56",
                "name" => "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
                "price" => 29.95,
                "description" => "100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON",
                "category" => "women's clothing",
                "thumbnail" => "/81XH0e8fefL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 2.9,
                    "count" => 340
                },
                "thumbnails" => [
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg",
                    "/81XH0e8fefL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "57",
                "name" => "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
                "price" => 39.99,
                "description" => "Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.",
                "category" => "women's clothing",
                "thumbnail" => "/71HblAHs5xL._AC_UY879_-2.jpg",
                "rating" => {
                    "rate" => 3.8,
                    "count" => 679
                },
                "thumbnails" => [
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg",
                    "/71HblAHs5xL._AC_UY879_-2.jpg"
                ]
            },
            {
                "id" => "58",
                "name" => "MBJ Women's Solid Short Sleeve Boat Neck V ",
                "price" => 9.85,
                "description" => "95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem",
                "category" => "women's clothing",
                "thumbnail" => "/71z3kpMAYsL._AC_UY879_.jpg",
                "rating" => {
                    "rate" => 4.7,
                    "count" => 130
                },
                "thumbnails" => [
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg",
                    "/71z3kpMAYsL._AC_UY879_.jpg"
                ]
            },
            {
                "id" => "59",
                "name" => "Opna Women's Short Sleeve Moisture",
                "price" => 7.95,
                "description" => "100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort",
                "category" => "women's clothing",
                "thumbnail" => "/51eg55uWmdL._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 4.5,
                    "count" => 146
                },
                "thumbnails" => [
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg",
                    "/51eg55uWmdL._AC_UX679_.jpg"
                ]
            },
            {
                "id" => "60",
                "name" => "DANVOUY Womens T Shirt Casual Cotton Short",
                "price" => 12.99,
                "description" => "95%Cotton,5%Spandex, Features => Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion => Casual/Office/Beach/School/Home/Street. Season => Spring,Summer,Autumn,Winter.",
                "category" => "women's clothing",
                "thumbnail" => "/61pHAEJ4NML._AC_UX679_.jpg",
                "rating" => {
                    "rate" => 3.6,
                    "count" => 145
                },
                "thumbnails" => [
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg",
                    "/61pHAEJ4NML._AC_UX679_.jpg"
                ]
            }
        ].map { |p| p.select { |k| ["id", "name", "description", "price", "category", "thumbnail"].include?(k) } }
    end
end
