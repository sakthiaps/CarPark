Rails.application.routes.draw do
  scope defaults: { format: 'json' } do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    match '/carparks/nearest',to: 'carparks#nearest', via: 'get'
  end
end
