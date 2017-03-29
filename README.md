# README

## Versions
- MongoDB v2.6.6
- Rails 5.0.2
- Ruby 2.3.3p222

## Seed the Database
- run "rake db:seed"

## Wipe the Database
- run "rake db:seed seed=false"

## Define and explain a set of data models that facilitate menu item pricing determined by a combination of 3 factors: restaurant location, order type, and time of day.

There are 7 data models that facilitate menu item pricing:
- Brands
  - Locations
    - Day Parts
    - Price Level Configurations
  - Menu Items
  - Order Types
  - Price Levels

Brands can have many Locations, Menu Items, Order Types and Price Levels.

Each Location can have many Day Parts but only a single Price Level Configuration (PLC) per each Location's Brand's Price Level.

For example, let's say Nike has the following Price Levels:
- Low-End
- Mid-End
- High-End

and has 3 Locations:
- Uptown
- Midtown
- Downtown


Each of Nike's locations will a PLC per each of Nike's Price Levels e.g.
- Uptown
  - Low-End PLC
  - Mid-End PLC
  - High-End PLC
- Midtown
  - Low-End PLC
  - Mid-End PLC
  - High-End PLC
- Downtown
  - Low-End PLC
  - Mid-End PLC
  - High-End PLC

Each PLC consists of a Price Level, Order Type and Day Part.
Only the Order Type and Day Part of the PLC can be changed and
each PLC's combination of Order Type and Day Part must be unique within
their respective location e.g. if Uptown's Low-End PLC consists of the "In-Store" Order Type and
the "Afternoon" Day Part, no other PLC within Uptown can consist of the "In-Store"
Order Type and the "Afternoon" Day Part. This ensures that an Order Type and Day Part only
maps to one of the Brand's Price Levels.

How Does Menu Item Pricing Work then?

In pricing, a Location specifies it's current Order Type and an optional Day Part. Pricing will then attempt to find the Location's PLC that matches the Order Type and Day Part. If no match exists, pricing will then attempt to find the Location's PLC that matches the Order Type. If no match exists again, then the Menu Items will not have a price since pricing could not a find an
appropriate PLC. However if a matching PLC is found, we take the Price Level that the PLC matches
to and apply it to the Menu Item(s) being sold.

For example, let's say we're doing pricing for Nike's Uptown Location. The Location's Order Type is "In-Store" and the Day Part is "Afternoon". We find a PLC within Nike's Uptown Location that has the same Order Type and Day Part which we know to be Uptown's Low-End PLC from our previous example (If we could not find a matching PLC, pricing would attempt to find a PLC with the same order type in Nike's Uptown Location). Uptown's Low-End PLC maps to Nike's Low-End Price Level. Let's say that all items in the Low-End Price Level have a cost of $2.00. Therefore, all of Nike's Uptown Location's Menu Items will have a cost of $2.00 because the Location's current Order Type and Day Part map to the Low-End Price Level which prices all Menu Items to $2.00. That's how Menu Item pricing is determined by a resturant's Location, Order Type and Day Part.





