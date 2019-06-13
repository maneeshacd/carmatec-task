Rails.application.routes.draw do
  root 'item_categories#index'
  resources :item_categories do
    resources :items
  end
  resources :item_taxes
  get :categories_with_items, to: 'item_categories#categories_with_items'
  post :selected_items, to: 'items#selected_items'
end
