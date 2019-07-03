Rails.application.routes.draw do
	resources :details
	get 'category_details' => "details#fetch_details"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
