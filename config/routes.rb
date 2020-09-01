Rails.application.routes.draw do

  root  'blocks#index'

  get   "login",                to: "sessions#new"
  post  "login",                to: "sessions#create"
  get   "logout",               to: "sessions#destroy"
  post  "logout",               to: "sessions#destroy"

  get   "api/certification_thickness/:shop_order",  to: "api#certification_thickness"

  resources :readings
  resources :blocks do
    collection do
      get 'reset_filters'
      get 'reset_filter'
    end
  end
  resources :xrays

end