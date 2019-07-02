namespace :serp  do
	task get_categories: :environment do 
		res = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600") rescue ""
		if res.present?
			categories_keys = res.keys
			model_names = categories_keys.map{|str| str.sub(/./,&:capitalize).gsub("-",'').gsub(" " ,'').singularize}
			model_names.each_with_index do |model,index|
				table_exists = model.constantize rescue ""
				if table_exists.present?
					model_name = "#{model}".constantize
					view_page_url = res[categories_keys[index]] rescue ""
					if view_page_url.present?
						view_page_res = HTTParty.get(view_page_url) rescue ""
						if view_page_res.present?
							view_page_res.each do |cat_info|
								model_name.create(category_name:cat_info["category"],keyword_id:cat_info["kwid"],url:cat_info["url"],keyword:cat_info["kw"],search_type:cat_info["type"],exact_url_tracked:cat_info["exact"],kw_start_position:cat_info["start"],google_rank:cat_info["grank"],google_rank_history:cat_info["grankhistory"].to_s,bing_rank:cat_info["brank"],yahoo_rank:cat_info["yrank"],is_favorite:cat_info["isfav"],day_change:cat_info["day"],week_change: cat_info["week"],month_change:cat_info["month"],life_change:cat_info["life"],ranking_url:cat_info["rankingurl"],seo_compete_pages:cat_info["seocomp"],search_volume:cat_info["searchvolume"],tags:cat_info["tags"].to_s,last_update: cat_info["lastupdate"].to_s)
							end
							p "**** #{model_name}.constantize data saved" 
						end
					end
				end
			end
		end	
	end
end