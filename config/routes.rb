Rails.application.routes.draw do
  root 'item_categories#items'
  resources :item_categories do
    resources :items
  end
  resources :item_taxes
end
