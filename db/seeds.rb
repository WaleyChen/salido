# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Brand.all.destroy
DayPart.all.destroy
Location.all.destroy
MenuItem.all.destroy
OrderType.all.destroy
PriceLevel.all.destroy
PriceLevelConfig.all.destroy

if ENV["seed"].nil? || ENV["seed"] == true
  brands = ["Chikalicious", "Momofuku", "KFC", "Xian's Famous Food"]
  items = ["Beef Burger", "Chicken Burger", "Pork Burger", "Salad"]
  locations = ["Downtown", "Midtown", "Uptown"]

  dayParts = ["Breakfast", "Brunch", "Lunch", "Dinner"]
  orderTypes = ["Delivery", "Dine In", "Pick-Up"]
  priceLevels = [
    ["Breakfast", "Dine In", "Breakfast"],
    ["Delivery", "Delivery", ""],
    ["Dinner", "Dine In", "Dinner"],
    ["Lunch", "Dine In", "Lunch"],
    ["Lunch Delivery", "Delivery", "Lunch"]
  ]

  # item prices per price level
  itemPrices = [1.99, 2.99, 3.99, 4.99, 5.99]

  brands.each {|brandName|
    brand = Brand.create(name: brandName)

    items.each {|itemName|
      item = MenuItem.create(name: itemName)

      priceLevels.each_with_index {|plArr, index|
        item.prices[plArr[0]] = itemPrices[index]
      }

      brand.menuItems << item
    }

    priceLevels.each {|plArr|
      priceLevel = PriceLevel.create(name: plArr[0])
      brand.priceLevels << priceLevel
    }

    orderTypes.each {|otName|
      orderType = OrderType.create(name: otName)
      brand.orderTypes << orderType
    }

    locations.each {|locName|
      location = Location.create(name: locName)
      location.brandName = brandName
      brand.locations << location

      dayParts.each {|dpName|
        dayPart = DayPart.create(name: dpName)
        location.dayParts << dayPart
      }

      priceLevels.each {|pl_arr|
        plc = PriceLevelConfig.create()
        location.priceLevelConfigs << plc
        plc.location = location
        plc.priceLevelName = pl_arr[0]
        plc.orderTypeName = pl_arr[1]
        plc.dayPartName = pl_arr[2]
        plc.save
      }
    }
  }
end