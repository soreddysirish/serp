namespace :serp  do
	task get_categories: :environment do 
		res = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
		res = JSON.parse(res.body) rescue ""
		if res.present?
			categories_keys = res.keys
			model_names = categories_keys.map{|str| str.sub(/./,&:capitalize).gsub("-",'').gsub(" " ,'').singularize}
			model_names.each_with_index do |model,index|
				binding.pry
				table_exists = defined?model
			end
		end	
	end
end