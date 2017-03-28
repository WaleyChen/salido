# README

* Versions
- MongoDB v2.6.6
- Rails 5.0.2
- Ruby 2.3.3p222

* Seeding the Database
- run "rake db:seed"

* To Clear the Database and Not Seed
- run "rake db:seed seed=false"

Define and explain a set of data models that facilitate menu item pricing determined by a combination of 3 factors: restaurant location, order type, and time of day.

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
Low-End
Mid-End
High-End

and has 3 Locations:
Uptown
Midtown
Downtown

Each of Nike's locations will a PLC per each of Nike's Price Levels e.g.
Uptown
  - Low-End PLC
  - Mid-End PLC
  - High-End PLC
Midtown
  - Low-End PLC
  - Mid-End PLC
  - High-End PLC
Downtown
  - Low-End PLC
  - Mid-End PLC
  - High-End PLC

Each PLC consists of a Price Level, Order Type and Day Part.
Only the Order Type and Day Part of the PLC can be changed and
each PLC's cominbation of Order Type and Day Part must be unique within
their location e.g. if Uptown's Low-End PLC consists of the "In-Store" Order Type and
the "Afternoon" Day Part, no other PLC within Uptown can consist of the "In-Store"
Order Type and the "Afternoon" Day Part. This ensures that an Order Type and Day Part only
maps to one of the Brand's Price Levels.

How Does Menu Item Pricing Work then?
In pricing, a Location specifies it's current Order Type and Day Part. Pricing will then find
the Location's PLC that matches the Order Type and Day Part. That PLC will map to a Price Level.
We then apply that Price Level to the Menu Item(s) being sold e.g.

Let's say we're doing pricing for Nike's Uptown Location. The Location's Order Type is "In-Store" and the Day Part is "Afternoon". We find a PLC within Nike's Uptown Location that has the same Order Type and Day Part which we know to be Uptown's Low-End PLC from our previous example.
Uptown's Low-End PLC maps to Nike's Low-End Price Level. Let's say that all items in the Low-End
Price Level have a cost of $2.00. Therefore, all of Nike's Uptown Location Menu Items will then have a cost of $2.00 because the Location's current Order Type and Day Part map to the Low-End
Price Level which prices all Menu Items to be $2.00. And that's how Menu Item pricing is determined by a resturant's Location, Order Type and Day Part.





