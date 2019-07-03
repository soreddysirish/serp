namespace :serp  do
	task get_categories: :environment do 

		category_list = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
		category_keys = category_list.keys
		category_keys.each_with_index do |model,index|
			case model
			when "AE Q1 Hotels Keywords"
				table_name = Aeq1HotelsKeyword
			when "Emirates - UAE Campaign"
				table_name = EmiratesUaeCampaign
			when "India Flights"
				table_name = IndiaFlight
			when "India Hotels"
				table_name = IndiaHotel
			when "KSA Q1 Arabic Keywords"
				table_name = Ksaq1ArabicKeyword
			when "KSA Q1 Keywords"
				table_name = Ksaq1Keyword
			when "UAE Q1 Activities"
				table_name = Uaeq1Activity
			when "UAE Q1 Keywords"
				table_name=Uaeq1Keyword
			when "Visa"
				table_name = Visa
			else
				table_name = ""			
			end
			if table_name.present?
				view_page_url = category_list[model] rescue ""
				if view_page_url.present?
					view_page_res = HTTParty.get(view_page_url) rescue ""
					if view_page_res.present?
						view_page_res.each do |cat_info|
							table_name.create(category_name:cat_info["category"],keyword_id:cat_info["kwid"].to_i,url:cat_info["url"],keyword:cat_info["kw"],search_type:cat_info["type"],exact_url_tracked:cat_info["exact"],kw_start_position:cat_info["start"].to_i,google_rank:cat_info["grank"].to_i,google_rank_history:cat_info["grankhistory"].to_s,bing_rank:cat_info["brank"].to_i,yahoo_rank:cat_info["yrank"].to_i,is_favorite:cat_info["isfav"],day_change:cat_info["day"],week_change: cat_info["week"],month_change:cat_info["month"],life_change:cat_info["life"],ranking_url:cat_info["rankingurl"],seo_compete_pages:cat_info["seocomp"],search_volume:cat_info["searchvolume"].to_i,tags:cat_info["tags"].to_s,last_update: cat_info["lastupdate"].to_s)
						end
						p "**** #{table_name} data saved" 
					end
				end
			end
		end	
	end
end




