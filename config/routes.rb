Rails.application.routes.draw do
  resources :readings
  resources :blocks
  resources :xrays
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
