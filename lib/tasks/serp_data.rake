namespace :serp  do
	task get_categories: :environment do 

		# => develpment category_list = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600") 
		#=> production 
		category_list = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=ebc64c6dd0c89693e2609644fc421142")
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
			when "Flight India - Q2"
					table_name = FlightIndiaQ2
			when "KSA Arabic Q2"
				table_name = KsaArabicQ2
			when "KSA English Q2 Airlines"
				table_name = KsaEnglishQ2Airline
			when "KSA English Q2 Booking"
				table_name = KsaEnglishQ2Booking
			when "KSA English Q2 Generic"
				table_name = KsaEnglishQ2Generic
			when "KSA English Q2 Offers"
				table_name = KsaEnglishQ2Offer
			when "UAE Q2 Airlines"
				table_name = UaeQ2Airline
			when "UAE Q2 Booking"
				table_name = UaeQ2Booking
			when "UAE Q2 Generic"
				table_name = UaeQ2Generic	
			else
				table_name = ""			
			end
			if table_name.present?
				view_page_url = category_list[model] rescue ""
				if view_page_url.present?
					view_page_res = HTTParty.get(view_page_url) rescue ""
					if view_page_res.present?
						view_page_res.each do |cat_info|
							table_name.create(category_name:cat_info["category"],keyword_id:cat_info["kwid"].to_i,url:cat_info["url"],keyword:cat_info["kw"],search_type:cat_info["type"],exact_url_tracked:cat_info["exact"],kw_start_position:cat_info["start"].to_i,google_rank:cat_info["grank"].to_i,google_rank_history:cat_info["grankhistory"].to_s,bing_rank:cat_info["brank"].to_i,yahoo_rank:cat_info["yrank"].to_i,is_favorite:cat_info["isfav"],day_change:cat_info["day"],week_change: cat_info["week"],month_change:cat_info["month"],life_change:cat_info["life"],ranking_url:cat_info["rankingurl"],seo_compete_pages:cat_info["seocomp"],search_volume:cat_info["searchvolume"].to_i,tags:cat_info["tags"].to_s,last_update: cat_info["lastupdate"].to_s,google_page: cat_info["gpage"].to_i,region: cat_info["region"],language: cat_info["language"],featured_url: cat_info["has_featured_url"])
						end
						p "**** #{table_name} data saved" 
					end
				end
			end
		end	
	end

	task :import_csv => :environment do 
		
	end
 

end











	# rails g model UaeQ2Generic category_name string keyword_id:integer url keyword language region type search_type exact_url_tracked kw_start_position:integer target_position:integer google_page:integer  google_rank:integer google_rank_history:text  bing_rank:integer  yahoo_rank:integer is_favorite day_change week_change month_change life_change ranking_url seo_compete_pages search_volume:integer tags featured_url last_update quater_period:integer 

# alter table visas add column region varchar(50) AFTER keyword,add column language varchar(10) AFTER keyword, add column google_page int AFTER kw_start_position, add column featured_url varchar(250) AFTER tags;

# alter table aeq1_hotels_keywords add column target_position int AFTER kw_start_position;


