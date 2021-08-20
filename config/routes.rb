Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/api/homeassignment', to: 'search#search_keyword', as: 'search_keyword'
  get '/modal/index', to: 'modal#index', as: "modal_index"
end
