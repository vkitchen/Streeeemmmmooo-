Rails.application.routes.draw do
  # Weird route name but just matched the task description ¯\_(ツ)_/¯
  get "/results", to: "news#results"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
