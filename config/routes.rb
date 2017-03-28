Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'brands#manage'
  resources :brands do
    resources :menu_items
    resources :order
    resources :order_types
  end

  resources :locations do
    resources :day_parts
    resources :price_level_configs
  end

  resources :price_levels

  get 'edit_plc', to: 'price_level_configs#edit', as: :edit_plc

  get 'manage_brands', to: 'brands#manage', as: :manage_brands
  get 'manage_day_parts', to: 'day_parts#manage', as: :manage_day_parts
  get 'manage_locations', to: 'locations#manage', as: :manage_locations
  get 'manage_price_levels', to: 'price_levels#manage_price_levels', as: :manage_price_levels
  get 'manage_menu_items', to: 'menu_items#manage', as: :manage_menu_items
  get 'manage_order_types', to: 'order_types#manage', as: :manage_order_types

  get 'brand_price_levels/:brand_id', to: 'price_levels#brand_price_levels', as: :brand_price_levels

  get 'location_menu_items/:location_id', to: 'menu_items#location_menu_items', as: :location_menu_items
  # get 'location_price_levels/:location_id', to: 'price_levels#location_price_levels', as: :location_price_levels
end
