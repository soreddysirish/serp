Rails.application.routes.draw do
	resources :details
	root "details#dashboard"
	get 'dashboard' => "details#dashboard"
	get 'category/:category_name' => "details#category_details"
	get 'overall_categories' => "details#overall_categories_view"
	get 'authenticate_user' => "details#authenticate_user"
	get '*path' => redirect('/overall_categories_view')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 