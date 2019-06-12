Rails.application.routes.draw do
  root 'item_categories#items'
  resources :items
  resources :item_categories
  resources :item_taxes
end
