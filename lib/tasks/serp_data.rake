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
			when "Visa All"
				table_name = Visa
			when "Visa UAE - Q2"
				table_name = VisaUaeQ2
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
			when "UAE Q2 Airline Booking"
				table_name = UaeQ2AirlineBooking
			when "UAE Q2 Generic"
				table_name = UaeQ2Generic	
			when "Testing KSA"
				table_name = TestingKsa
			when "Temporary"
				table_name = Temporary
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
				# follow this order only 
				Rake::Task["serp:update_IndiaHotel_category_table"].execute

				Rake::Task["serp:update_IndiaHotel_new_category_table"].execute

				Rake::Task["serp:update_FlightIndiaQ2_category_table"].execute

				Rake::Task["serp:update_UaeQ2Airline_category_table"].execute

				Rake::Task["serp:update_uae_domain_categories"].execute

				Rake::Task["serp:update_KsaEnglishQ2Airline_category_table"].execute

				Rake::Task["serp:update_KsaArabicQ2_category_table"].execute

				Rake::Task["serp:update_KsaArabicQ2_quater2_category_table"].execute

				Rake::Task["serp:update_ksa_domain_categories"].execute
	end
	# run before  update_IndiaHotel_new_category_table task
	task :update_IndiaHotel_category_table => :environment do 
		CSV.foreach("public/csv_files/IndiaHotel.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = IndiaHotel.where(keyword: row[0],search_type: 'se',quater_period: 2)
			mobile_records = IndiaHotel.where(keyword: row[0],search_type: 'sem',quater_period: 2)
			desktop_target_position = row[3].to_i
			mobile_target_position = row[4].to_i
			desktop_records.update_all(target_position: desktop_target_position)
			mobile_records.update_all(target_position: mobile_target_position)
			puts "#{index+1} - update for keyword #{row[0]} - done"
		end
		puts "@@@  updation done!!"
	end

	task :update_IndiaHotel_new_category_table => :environment do 
		CSV.foreach("public/csv_files/IndiaHotel.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = IndiaHotel.where(keyword: row[0],search_type: 'se',quater_period: 2)
			mobile_records = IndiaHotel.where(keyword: row[0],search_type: 'sem',quater_period: 2)
			desktop_target_position = row[3].to_i
			mobile_target_position = row[4].to_i
			desktop_records.update_all(target_position: desktop_target_position)
			mobile_records.update_all(target_position: mobile_target_position)
			puts "#{index+1} - update for keyword #{row[0]} - done"
		end
		puts "@@@  updation done!!"
	end


	task :update_uae_domain_categories => :environment do 
		kas_csvs = Dir["public/csv_files/uae_csv_files/*.csv"]
		kas_csvs.each do |csv|
			CSV.foreach("#{csv}", :headers=>true).each_with_index do |row,index|
				model_name = csv.split("/").last.gsub(".csv",'').constantize
				desktop_records = model_name.where(keyword: row[0],search_type: 'se')
				mobile_records = model_name.where(keyword: row[0],search_type: 'sem')
				desktop_target_position = row[5].to_i
				mobile_target_position = row[9].to_i
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for categrory - #{model_name} for keyword #{row[0]} - done"
			end
		end
	end


	task :update_ksa_domain_categories => :environment do 
		kas_csvs = Dir["public/csv_files/ksa_csv_files/*.csv"]
		kas_csvs.each do |csv|
			CSV.foreach("#{csv}", :headers=>true).each_with_index do |row,index|
				model_name = csv.split("/").last.gsub(".csv",'').constantize
				desktop_records = model_name.where(keyword: row[0],search_type: 'se')
				mobile_records = model_name.where(keyword: row[0],search_type: 'sem')
				desktop_target_position = row[4].to_i
				mobile_target_position = row[7].to_i
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for categrory - #{model_name} for keyword #{row[0]} - done"
			end
		end
	end

	# run before update_uae_domain_categories
	task :update_UaeQ2Airline_category_table => :environment do 
		CSV.foreach("public/csv_files/UaeQ2Airline.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = UaeQ2Airline.where(keyword: row[0],search_type: 'se')
			mobile_records = UaeQ2Airline.where(keyword: row[0],search_type: 'sem')
			desktop_target_position = row[5].to_i
			mobile_target_position = row[9].to_i
			desktop_records.update_all(target_position: desktop_target_position)
			mobile_records.update_all(target_position: mobile_target_position)
			puts "#{index+1} - update for keyword #{row[0]} - done"
		end
		puts "@@@  updation done!!"
	end

  # run before update_ksa_domain_categories
  task :update_KsaEnglishQ2Airline_category_table => :environment do 
  	CSV.foreach("public/csv_files/KsaEnglishQ2Airline.csv", :headers=>true).each_with_index do |row,index|
  		desktop_records = KsaEnglishQ2Airline.where(keyword: row[0],search_type: 'se')
  		mobile_records = KsaEnglishQ2Airline.where(keyword: row[0],search_type: 'sem')
  		desktop_target_position = row[4].to_i
  		mobile_target_position = row[7].to_i
  		if desktop_records.any? || mobile_records.any? 
  			desktop_records.update_all(target_position: desktop_target_position)
  			mobile_records.update_all(target_position: mobile_target_position)
  			puts "#{index+1} - update for keyword #{row[0]} - done"
  		end
  	end
  	puts "@@@  updation done!!"
  end
	# run before update_ksa_domain_categories
	task :update_KsaEnglishQ2Generic_category_table => :environment do 
		CSV.foreach("public/csv_files/KsaEnglishQ2Airline.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = KsaEnglishQ2Generic.where(keyword: row[0],search_type: 'se')
			mobile_records = KsaEnglishQ2Generic.where(keyword: row[0],search_type: 'sem')
			desktop_target_position = row[4].to_i
			mobile_target_position = row[7].to_i
			if desktop_records.any? || mobile_records.any? 
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for keyword #{row[0]} - done"
			end
		end
		puts "@@@  updation done!!"
	end

	# run before update_ksa_domain_categories
	task :update_KsaEnglishQ2Booking_category_table => :environment do 
		CSV.foreach("public/csv_files/KsaEnglishQ2Airline.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = KsaEnglishQ2Booking.where(keyword: row[0],search_type: 'se')
			mobile_records = KsaEnglishQ2Booking.where(keyword: row[0],search_type: 'sem')
			desktop_target_position = row[4].to_i
			mobile_target_position = row[7].to_i
			if desktop_records.any? || mobile_records.any? 
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for keyword #{row[0]} - done"
			end
		end
		puts "@@@  updation done!!"
	end


	task :update_FlightIndiaQ2_category_table => :environment do 
		CSV.foreach("public/csv_files/FlightIndiaQ2.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = FlightIndiaQ2.where(keyword: row[0],search_type: 'se')
			mobile_records = FlightIndiaQ2.where(keyword: row[0],search_type: 'sem')
			desktop_target_position = row[4].to_i
			mobile_target_position = row[5].to_i
			if desktop_records.any? || mobile_records.any? 
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for keyword #{row[0]} - done"
			end
		end
		puts "@@@  updation done!!"
	end

	

	#  run before update_KsaArabicQ2_quater2_category_table task 

	task :update_KsaArabicQ2_category_table => :environment do 
		CSV.foreach("public/csv_files/KsaArabicQ2.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = KsaArabicQ2.where(keyword: row[0],search_type: 'se')
			mobile_records = KsaArabicQ2.where(keyword: row[0],search_type: 'sem')
			desktop_target_position = row[5].to_i
			mobile_target_position = row[8].to_i
			if desktop_records.any? || mobile_records.any? 
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for keyword #{row[0]} - done"
			end
		end
		puts "@@@  updation done!!"
	end

	task :update_KsaArabicQ2_quater2_category_table => :environment do 
		CSV.foreach("public/csv_files/KsaArabicQ2_new.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = KsaArabicQ2.where(keyword: row[0],search_type: 'se')
			mobile_records = KsaArabicQ2.where(keyword: row[0],search_type: 'sem')
			desktop_target_position = row[5].to_i
			mobile_target_position = row[8].to_i
			if desktop_records.any? || mobile_records.any? 
				desktop_records.update_all(target_position: desktop_target_position)
				mobile_records.update_all(target_position: mobile_target_position)
				puts "#{index+1} - update for keyword #{row[0]} - done"
			end
		end
		puts "@@@  updation done!!"
	end

end











	# rails g model  VisaUaeQ2 category_name string keyword_id:integer url keyword language region type search_type exact_url_tracked kw_start_position:integer target_position:integer google_page:integer  google_rank:integer google_rank_history:text  bing_rank:integer  yahoo_rank:integer is_favorite day_change week_change month_change life_change ranking_url seo_compete_pages search_volume:integer tags featured_url last_update quater_period:integer 

# alter table visas add column region varchar(50) AFTER keyword,add column language varchar(10) AFTER keyword, add column google_page int AFTER kw_start_position, add column featured_url varchar(250) AFTER tags;

# alter table aeq1_hotels_keywords add column target_position int AFTER kw_start_position;


