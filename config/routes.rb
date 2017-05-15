Rails.application.routes.draw do
  devise_for :students
  resources :lendings, except: [:new, :edit, :destroy, :create]
  resources :bicycles, except: [:new, :edit]
  resources :references
  resources :students
  resources :stations, except: [:new, :edit]
  get 'validate/:code', to: 'students#validate_student'
  post 'assign', to: 'lendings#assign'
  post 'return', to: 'lendings#return_bicycle'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
