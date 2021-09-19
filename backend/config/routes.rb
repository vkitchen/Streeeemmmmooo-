Rails.application.routes.draw do
  get "/results", to: "news#results"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
