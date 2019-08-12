namespace :serp  do
	
	task get_categories: :environment do 
		# def create_table(model_name)
		# 	sh "rails g model  #{model_name} category_name string keyword_id:integer url keyword language region type search_type exact_url_tracked kw_start_position:integer target_position:integer google_page:integer  google_rank:integer google_rank_history:text  bing_rank:integer  yahoo_rank:integer is_favorite day_change week_change month_change life_change ranking_url seo_compete_pages search_volume:integer tags featured_url last_update quater_period:integer "
		# 		Rake::Task['db:migrate'].invoke
		# 		puts "created table - #{model_name}"
		# end

		# => develpment category_list = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600") 
		#=> production 
		
		category_list = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=ebc64c6dd0c89693e2609644fc421142")

		Rails.application.eager_load!
		@model_array = ApplicationRecord.descendants.collect(&:name)
		# existing_tables = ActiveRecord::Base.connection.tables - ["ar_internal_metadata","schema_migrations"]
		# models = existing_tables.map{|t| t.singularize.camelize.constantize }
		category_keys = category_list.keys
		# category_keys = []
		category_keys.each do |k|
			model_name = k.downcase.titleize.gsub(" ","").gsub("  ","").gsub("-","")
			table_name = k.downcase.gsub("  "," ").gsub(" ","_").gsub("-","")
			if !@model_array.include?(model_name)
				puts "#{model_name} --- #{k}"
				system "rails g model  #{model_name} category_name string keyword_id:integer url keyword language region type search_type exact_url_tracked kw_start_position:integer target_position:integer google_page:integer  google_rank:integer google_rank_history:text  bing_rank:integer  yahoo_rank:integer is_favorite day_change week_change month_change life_change ranking_url seo_compete_pages search_volume:integer tags featured_url last_update quater_period:integer " rescue next
				Rake::Task['db:migrate'].invoke 
				puts "created table - #{model_name}"
			end
			if model_name.present?
				model_name = model_name.constantize
				model_name.where("created_at >=?",Time.now.beginning_of_day).delete_all
				view_page_url = category_list[k] rescue ""
				if view_page_url.present?
					view_page_res = HTTParty.get(view_page_url) rescue ""
					if view_page_res.present?
						view_page_res.each do |cat_info|
							model_name.create(category_name:cat_info["category"],keyword_id:cat_info["kwid"].to_i,url:cat_info["url"],keyword:cat_info["kw"],search_type:cat_info["type"],exact_url_tracked:cat_info["exact"],kw_start_position:cat_info["start"].to_i,google_rank:cat_info["grank"].to_i,google_rank_history:cat_info["grankhistory"].to_s,bing_rank:cat_info["brank"].to_i,yahoo_rank:cat_info["yrank"].to_i,is_favorite:cat_info["isfav"],day_change:cat_info["day"],week_change: cat_info["week"],month_change:cat_info["month"],life_change:cat_info["life"],ranking_url:cat_info["rankingurl"],seo_compete_pages:cat_info["seocomp"],search_volume:cat_info["searchvolume"].to_i,tags:cat_info["tags"].to_s,last_update: cat_info["lastupdate"].to_s,google_page: cat_info["gpage"].to_i,region: cat_info["region"],language: cat_info["language"],featured_url: cat_info["has_featured_url"]) rescue next
						end
						p "**** #{model_name} data saved" 
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
			desktop_records = IndiaHotels.where(keyword: row[0],search_type: 'se',quater_period: 2)
			mobile_records = IndiaHotels.where(keyword: row[0],search_type: 'sem',quater_period: 2)
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
			desktop_records = IndiaHotels.where(keyword: row[0],search_type: 'se',quater_period: 2)
			mobile_records = IndiaHotels.where(keyword: row[0],search_type: 'sem',quater_period: 2)
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
		CSV.foreach("public/csv_files/UaeQ2Airlines.csv", :headers=>true).each_with_index do |row,index|
			desktop_records = UaeQ2Airlines.where(keyword: row[0],search_type: 'se')
			mobile_records = UaeQ2Airlines.where(keyword: row[0],search_type: 'sem')
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
  	CSV.foreach("public/csv_files/KsaEnglishQ2Airlines.csv", :headers=>true).each_with_index do |row,index|
  		desktop_records = KsaEnglishQ2Airlines.where(keyword: row[0],search_type: 'se')
  		mobile_records = KsaEnglishQ2Airlines.where(keyword: row[0],search_type: 'sem')
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

	task create_tables: :environment do 
		category_list = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=ebc64c6dd0c89693e2609644fc421142")
		Rails.application.eager_load!
		@model_array = ApplicationRecord.descendants.collect(&:name)
		category_keys = category_list.keys
		category_keys.each_with_index do |k,v|
			model_name = k.downcase.titleize.gsub(" ","").gsub("  ","").gsub("-","")
			table_name = k.downcase.gsub("  "," ").gsub(" ","_").gsub("-","")
			if !@model_array.include?(model_name) 
				sh "rails g model  #{table_name} category_name string keyword_id:integer url keyword language region type search_type exact_url_tracked kw_start_position:integer target_position:integer google_page:integer  google_rank:integer google_rank_history:text  bing_rank:integer  yahoo_rank:integer is_favorite day_change week_change month_change life_change ranking_url seo_compete_pages search_volume:integer tags featured_url last_update quater_period:integer "
				Rake::Task['db:migrate'].invoke
				puts "created table - #{table_name}"

			end
		end
	end
end






		# sql_query =  "create table testtttt(category_name varchar(100),keyword_id int, url varchar(100),keyword varchar(100),language varchar(50),region varchar(50),type varchar(10),search_type varchar(10),exact_url_tracked varchar(100),kw_start_position int,target_position int,google_page int, google_rank int, google_rank_history text, bing_rank int, yahoo_rank int, is_favorite varchar(10),day_change varchar(10),week_change varchar(10),month_change varchar(10),life_change varchar(10),ranking_url varchar(100),seo_compete_pages varchar(20),search_volume int,tags varchar(50),featured_url varchar(30),last_update varchar(250),quater_period int,created_at TIMESTAMP,updated_at TIMESTAMP); "
				# binding.pry
  	# ActiveRecord::Base.connection.execute(sql_query)

  

  # create table flight_ind(category_name varchar(100),keyword_id int, url varchar(100),keyword varchar(100),language varchar(50),region varchar(50),type varchar(10),search_type varchar(10),exact_url_tracked varchar(100),kw_start_position int,target_position int,google_page int, google_rank int, google_rank_history text, bing_rank int, yahoo_rank int, is_favorite varchar(10),day_change varchar(10),week_change varchar(10),month_change varchar(10),life_change varchar(10),ranking_url varchar(100),seo_compete_pages varchar(20),search_volume int,tags varchar(50),featured_url varchar(30),last_update varchar(250),quater_period int,created_at TIMESTAMP,updated_at TIMESTAMP);

	# rails g model  KsaTest category_name string keyword_id:integer url keyword language region type search_type exact_url_tracked kw_start_position:integer target_position:integer google_page:integer  google_rank:integer google_rank_history:text  bing_rank:integer  yahoo_rank:integer is_favorite day_change week_change month_change life_change ranking_url seo_compete_pages search_volume:integer tags featured_url last_update quater_period:integer 
	
# alter table visas add column region varchar(50) AFTER keyword,add column language varchar(10) AFTER keyword, add column google_page int AFTER kw_start_position, add column featured_url varchar(250) AFTER tags;

# alter table aeq1_hotels_keywords add column target_position int AFTER kw_start_position;


