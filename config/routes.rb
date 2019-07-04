Rails.application.routes.draw do
	resources :details
	get 'dashboard' => "details#dashboard"
	get 'category/:category_name' => "details#category_details"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
