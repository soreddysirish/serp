class DetailsController < ApplicationController

	def dashboard
		# categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600") - old key
		categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=ebc64c6dd0c89693e2609644fc421142")
		categories_keys = categories_list.keys
		@categories = {"AE Q1 Hotels Keywords":{},"Emirates - UAE Campaign":{},"India Flights":{},"India Hotels":{},"KSA Q1 Arabic Keywords":{},"KSA Q1 Keywords":{},"UAE Q1 Activities":{},"UAE Q1 Keywords":{},"Visa":{}}
		categories_array = []
		cat_obj ={}
		categories_keys.each_with_index do |key,index|
			table_name = get_table_name(key)
			obj = {}
			@rank_one_keywords = table_name.where(google_rank: 1) rescue []
			@rank_one_keywords_count = @rank_one_keywords.pluck(:keyword).uniq.count rescue 0
			@rank_in_between_two_and_three = table_name.where(google_rank: 2..3) rescue []
			@rank_in_between_two_and_three_count = @rank_in_between_two_and_three.pluck(:keyword).uniq.count rescue 0
			@rank_in_between_four_and_ten = table_name.where(google_rank: 4..10) rescue []
			@rank_in_between_four_and_ten_count = @rank_in_between_four_and_ten.pluck(:keyword).uniq.count rescue 0
			@rank_in_between_ten_and_twenty = table_name.where(google_rank: 10..20) rescue []
			@rank_in_between_ten_and_twenty_count = @rank_in_between_ten_and_twenty.pluck(:keyword).uniq.count rescue 0
			@rank_above_twenty = table_name.where("google_rank > ?",20 ) rescue []
			@rank_above_twenty_count = @rank_above_twenty.pluck(:keyword).uniq.count rescue 0
			@categories["#{key}"] = {"rank_one_keywords" => @rank_one_keywords_count,
				"rank_in_between_two_and_three" => @rank_in_between_two_and_three_count,
				"rank_in_between_four_and_ten"=>@rank_in_between_four_and_ten_count,
				"rank_in_between_ten_and_twenty"=>@rank_in_between_ten_and_twenty_count,
				"rank_above_twenty"=>@rank_above_twenty_count}
				categories_array << key
			end
			list = {}
			list["categories_keys"] = categories_array
			list["categories_data"] = @categories
			render json: list
		end

		def category_details
			@category_name = params[:category_name].split("_").join(" ")
			if @category_name == "Emirates UAE Campaign" 
				@category_name = "Emirates - UAE Campaign" 
			elsif @category_name == "Flight India Q2"
				@category_name  = "Flight India - Q2"
			end
			categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=ebc64c6dd0c89693e2609644fc421142")
			categories_keys = categories_list.keys
			category_exist = categories_keys.include?(@category_name)
			column_headings = []
			table_headings = {"category_name" => "Category Name","tags" => "Tag","keyword" => "Keyword","start_date" => "Start Date","current_date" => "Current Date","percentage" => "Percentage","search_volume"=> "Search Volume","kw_start_position" => "Keyword Start Position","google_rank_history" => "Google Rank History","day_change" => "Day","week_change"=> "Week","month_change"=>"Month", "life_change" => "Life Change","region" => "Region","language"=>"Language"}
			if category_exist
				category_table_name = get_table_name(@category_name)
				keywords = category_table_name.all.pluck(:keyword).uniq

				category_details_obj = []
				keywords.each do |kw|
				# start_date_records = category_table_name.where("keyword=? and Date(created_at) = ?",kw, "2019-07-02")
				# first_record  = start_date_records.first rescue ""
				# kw_start_position = first_record.kw_start_position rescue ""
				ranks_array = []
				ranks_obj = { "start_date_ranks" => {"desktop_rank"=> "","mobile_rank"=>""},						
				"current_date_ranks"=>{"moblie_intial_position"=>"","desktop_intial_position"=>"","mobile_rank" => "","desktop_rank" => "","desktop_target_position" => 0,"mobile_target_position" => 0,"types"=> {}}
			}
			types = {}
			tags = {}
				# start_date_ranks = {"mobile_rank" => "","desktop_rank" => ""}
				current_date_ranks = {"moblie_intial_position"=>"","desktop_intial_position"=>"","mobile_rank" => "","desktop_rank" => "","desktop_target_position" => "","mobile_target_position" => ""}
				search_volumes = {"mobile_search_volume"=> 0,"desktop_search_volume"=>0}
				# start_date_records.each do |sr|i
				# 	if sr.search_type == "sem"
				# 		start_date_ranks["mobile_rank"] = sr.kw_start_position rescue 0
				# 		types["mobile_type"] = sr.search_type
				# 	else 
				# 		start_date_ranks["desktop_rank"] = sr.kw_start_position rescue 0
				# 		types["desktop_type"] = sr.search_type
				# 	end
				# 	ranks_obj["start_date_ranks"] = start_date_ranks rescue 0
				# 	ranks_obj["types"] = types
				# 	ranks_array << ranks_obj
				# end
				current_date_records = category_table_name.where("keyword=? and Date(created_at) = ? ",kw, Date.today.to_s(:db))
				current_date_first_record = current_date_records.first
				google_rank_history = eval(current_date_first_record.google_rank_history) rescue []
				cycle_changes = {}
				cycle_changes["day_change"] = current_date_first_record.day_change rescue ""
				cycle_changes["week_change"] = current_date_first_record.week_change rescue ""
				cycle_changes["month_change"] = current_date_first_record.month_change rescue ""
				cycle_changes["life_change"] = current_date_first_record.life_change rescue ""
				google_ranking_url = current_date_first_record.ranking_url rescue ""
				google_page = current_date_first_record.google_page rescue ""
				google_rank = current_date_first_record.google_rank rescue ""
				bing_rank = current_date_first_record.bing_rank rescue ""
				yahoo_rank = current_date_first_record.yahoo_rank rescue  ""
				language = current_date_first_record.language rescue ""
				region = current_date_first_record.region  rescue ""
				domain = current_date_first_record.url rescue ""
				category_name = current_date_first_record.category_name rescue ""
					# tag = current_date_first_record.tags rescue ""
					keyword = current_date_first_record.keyword rescue ""
					search_volume = current_date_first_record.search_volume rescue ""
					kw_start_position = current_date_first_record.kw_start_position rescue ""
					current_date_records.each do |cr|
						if cr.search_type == "sem"
							current_date_ranks["mobile_rank"] = cr.google_rank rescue "N/A"
							current_date_ranks["moblie_intial_position"] = cr.kw_start_position rescue "N/A"
							current_date_ranks["mobile_target_position"] = cr.target_position rescue "N/A"
							types["mobile_type"] = cr.search_type
							tags["mobile_tag"] = cr.tags rescue ""
						else
							current_date_ranks["desktop_rank"] = cr.google_rank rescue "N/A"
							current_date_ranks["desktop_intial_position"] = cr.kw_start_position rescue "N/A"
							current_date_ranks["desktop_target_position"] = cr.target_position rescue "N/A"
							types["desktop_type"] = cr.search_type
							tags["desktop_tag"] = cr.tags rescue ""
						end
						ranks_obj["current_date_ranks"] = current_date_ranks
						ranks_array << ranks_obj
					end
					if current_date_ranks["mobile_target_position"].to_i != 0 && current_date_ranks["desktop_target_position"].to_i != 0
						mobile_rank_percentage = ((current_date_ranks["mobile_target_position"].to_f - current_date_ranks["mobile_rank"].to_f)/current_date_ranks["mobile_target_position"].to_f)*100
						desktop_rank_percentage = ((current_date_ranks["desktop_target_position"].to_f - current_date_ranks["desktop_rank"].to_f)/current_date_ranks["desktop_target_position"].to_f)*100
					else
						mobile_rank_percentage = ((current_date_ranks["moblie_intial_position"].to_f - current_date_ranks["mobile_rank"].to_f)/current_date_ranks["moblie_intial_position"].to_f)*100
						desktop_rank_percentage = ((current_date_ranks["desktop_intial_position"].to_f - current_date_ranks["desktop_rank"].to_f)/current_date_ranks["desktop_intial_position"].to_f)*100
					end
					
					percentage = {}
					percentage["desktop_rank_percentage"] = desktop_rank_percentage.round(2) rescue 0 
					percentage["mobile_rank_percentage"] = mobile_rank_percentage.round(2) rescue 0 
					category_details_obj << {"domain"=>domain,"category_name" => category_name,"tags" => tags,"keyword" => keyword,"start_date_ranks" =>"","current_date_ranks" => current_date_ranks,"percentage" => percentage,"search_volume" => search_volume,"kw_start_position" => kw_start_position,"google_rank_history"=> google_rank_history,cycle_changes: cycle_changes,google_ranking_url: google_ranking_url,"google_page" => google_page,"region" => region ,"language"=> language,google_rank: google_rank,"bing_rank" => bing_rank,"yahoo_rank" => yahoo_rank,"types" => types}

					# mobile_start_date_records = category_table_name.where("keyword=? and Date(created_at) = ? and search_type='sem'",kw, "2019-07-02")
					# mobile_current_date_records = category_table_name.where("keyword=? and Date(created_at) = ?  and search_type='sem'", Date.today.to_s(:db))
				end
				# start_date = eval(category_table_name.group(:keyword).first.last_update)["date"]
				# current_date = Date.today.to_formatted_s(:long_ordinal)
				table_columns = category_table_name.column_names
				table_columns.push("start_date","current_date")
				heading_obj = {}
				#no need
				# table_columns.each do |tc|
				# 	if table_headings["#{tc}"].present?  
				# 	heading_obj = {"accessor" => "#{tc}","heading" => table_headings["#{tc}"]}
				# 	column_headings << heading_obj
				# 	end
				# end
			end
			render json: {category_details_obj:  category_details_obj,headings: column_headings,categories_keys: categories_keys}
		end

		def overall_categories_view
			categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=ebc64c6dd0c89693e2609644fc421142")
			categories_keys = categories_list.keys
			categories_array = []
			cat_obj ={}
			category_name = ""
			start_date_total_keywords = {}
			current_date_total_keywords = {}
			target_total_keywords ={}
			categories_keys.each_with_index do |key,index|
				category_name = key
				category_table_name = get_table_name(key)
				if category_table_name.present? && category_table_name != ""
					start_date = "2019-07-02"
					current_date =  Date.today.to_s(:db)
					# total_keywords = category_table_name.where("Date(created_at)=?","#{current_date}").pluck(:keyword) rescue []
					total_keywords = category_table_name.where("Date(created_at)=?","#{current_date}").group(:search_type,:keyword).pluck(:keyword) rescue []
					total_keywords_count = total_keywords.count
					# category_table_start_grouped = category_table_name.select("DISTINCT keyword").where("DISTINCT keyword and Date(created_at)=?","#{start_date}").group(:google_rank).count
					# category_table_start_grouped = category_table_name.where("Date(created_at)=?","#{start_date}").group(:google_rank).count
				# start_date_total_keywords["top_1"] = category_table_name.where("google_rank in (?) and Date(created_at)=?",1,"#{start_date}").count rescue 0
				# start_date_total_keywords["top_2_3"] = category_table_name.where("google_rank in (?) and Date(created_at)=?",2..3,"#{start_date}").count rescue 0

				# start_date_total_keywords["top_4_10"] = category_table_name.where("google_rank in (?) and Date(created_at)=?",4..10,"#{start_date}").count rescue 0
				# start_date_total_keywords["rank_above_10"] = category_table_name.where("google_rank > 10 and Date(created_at)" ,"#{start_date}").count rescue 0
				# current_date_total_keywords["rank_1"] = category_table_name.where("google_rank in (?) and Date(created_at)=?",1,"#{current_date}").count rescue 0
				# current_date_total_keywords["rank_2_3"] = category_table_name.where("google_rank in (?) and Date(created_at)=?",2..3,"#{current_date}").count rescue 0
				# current_date_total_keywords["rank_4_10"] = category_table_name.where("google_rank in (?) and Date(created_at)=?",4..10,"#{current_date}").count rescue 0
				# current_date_total_keywords["rank_above_10"] = category_table_name.where("google_rank > 10 and Date(created_at)","#{current_date}").count rescue 0

					category_table_current_grouped = category_table_name.where("Date(created_at)=?","#{current_date}").group(:google_rank).count rescue {}
					category_table_start_grouped = category_table_name.where("Date(created_at)=?","#{start_date}").group(:google_rank).count  rescue {}
					target_grouped = category_table_name.where("Date(created_at)=?","#{current_date}").group(:target_position).count rescue {}
					unless category_table_start_grouped.present?  
						start_date = "2019-07-25"
						category_table_start_grouped = category_table_name.where("Date(created_at)=?","#{start_date}").group(:google_rank).count
					end
					# current_date_records = category_table_name.where("Date(created_at)=?","#{current_date}")
					current_unranked = 0
					current_top_1 = 0
					current_top_2_3 = 0
					current_top_4_10 = 0
					current_above_10 = 0
					start_unranked = 0
					start_top_1 = 0
					start_top_2_3 = 0
					start_top_4_10 = 0
					start_above_10 = 0
					target_top_1 = 0
					target_top_2_3 = 0
					target_top_4_10 = 0
					target_above_10 = 0
					target_unranked = 0
					if category_table_start_grouped.present?
						not_tracked = []
						category_table_start_grouped.each do|rank,value|
							if rank==1
								start_top_1 += value
							elsif rank==2 || rank==3
								start_top_2_3 += value
							elsif rank > 3 && rank < 11
								start_top_4_10 += value
							elsif rank > 10
								start_above_10 += value
							else
								not_tracked << value
								start_unranked = not_tracked.reduce(:+) rescue 0
							end
						end
					end
					if category_table_current_grouped.present?
						not_tracked = []
						category_table_current_grouped.each do|rank,value|
							if rank==1
								current_top_1 += value
							elsif rank==2 || rank==3
								current_top_2_3 += value
							elsif rank > 3 && rank < 11
								current_top_4_10 += value
							elsif rank > 10
								current_above_10 += value
							else
								not_tracked << value
								current_unranked = not_tracked.reduce(:+) rescue 0
							end
						end
					end
					if target_grouped.present?
						not_tracked = []
						target_grouped.each do |rank,value|
							rank = rank.nil? ? 0 : rank 
							if rank==1
								target_top_1 += value
							elsif rank==2 || rank==3
								target_top_2_3 += value
							elsif rank > 3 && rank < 11
								target_top_4_10 += value
							elsif rank > 10
								target_above_10 +=  value
							else
								not_tracked << value
								target_unranked = not_tracked.reduce(:+) rescue 0
							end
						end
					end
					start_date_total_keywords["unranked"] = start_unranked
					current_date_total_keywords["unranked"] = current_unranked
					start_date_total_keywords["rank_1"] = start_top_1/2 rescue 0
					start_date_total_keywords["rank_2_3"] = start_top_2_3/2 rescue 0
					start_date_total_keywords["rank_4_10"] = start_top_4_10/2 rescue 0
					start_date_total_keywords["rank_above_10"] = start_above_10/2 rescue 0
					current_date_total_keywords["rank_1"] = current_top_1 rescue 0
					current_date_total_keywords["rank_2_3"] = current_top_2_3 rescue 0
					current_date_total_keywords["rank_4_10"] = current_top_4_10 rescue 0
					current_date_total_keywords["rank_above_10"] = current_above_10 rescue 0
					target_total_keywords["target_unranked"] = target_unranked rescue 0
					target_total_keywords["target_top_4_10"] = target_top_4_10 rescue 0
					target_total_keywords["target_above_10"] = target_above_10 rescue 0
					target_total_keywords["target_top_2_3"] = target_top_2_3 rescue 0
					target_total_keywords["target_top_1"] = target_top_1 rescue 0
					cat_obj["category_name"] = key
					cat_obj["total_keywords"] = total_keywords
					cat_obj["count"] = total_keywords_count
					cat_obj["start_date_kws"] = start_date_total_keywords
					cat_obj["current_date_kws"] = current_date_total_keywords
					cat_obj["target_kws"] = target_total_keywords
					categories_array.push(JSON.parse(cat_obj.to_json))
					puts "#{index} is completed"
				end
			end
			render json: categories_array
		end


		def authenticate_user
			@user = User.find_by(name:params["username"])
			if @user.present?
				if @user.authenticate(params["password"])
					secret = Rails.application.secrets.secret_key_base 
					data={ name:params["username"] }
					pay_load={data:data,exp: (Time.now+10.minutes).to_i}
					token = JWT.encode(pay_load,secret,'HS256')
					render json: {token:token},status: 200
				end
			else
				render json:{error: 'unauthorised user'},status: 500
			end
		end

		def get_table_name(key)
			case key
			when "AE Q1 Hotels Keywords"
				category_table_name = Aeq1HotelsKeyword
			when "Emirates UAE Campaign"
				category_table_name = EmiratesUaeCampaign
			when "Emirates - UAE Campaign"
				category_table_name = EmiratesUaeCampaign
			when "India Flights"
				category_table_name = IndiaFlight
			when "India Hotels"
				category_table_name = IndiaHotel
			when "KSA Q1 Arabic Keywords"
				category_table_name = Ksaq1ArabicKeyword
			when "KSA Q1 Keywords"
				category_table_name = Ksaq1Keyword
			when "UAE Q1 Activities"
				category_table_name = Uaeq1Activity
			when "UAE Q1 Keywords"
				category_table_name= Uaeq1Keyword
			when "Visa All"
				category_table_name = Visa
			when "Visa UAE - Q2"
				category_table_name = VisaUaeQ2
			when  "Visa UAE Q2"
				category_table_name = VisaUaeQ2
			when "Flight India - Q2"
				category_table_name = FlightIndiaQ2
			when "KSA Arabic Q2"
				category_table_name = KsaArabicQ2
			when "KSA English Q2 Airlines"
				category_table_name = KsaEnglishQ2Airline
			when "KSA English Q2 Booking"
				category_table_name = KsaEnglishQ2Booking
			when "KSA English Q2 Generic"
				category_table_name = KsaEnglishQ2Generic
			when "KSA English Q2 Offers"
				category_table_name = KsaEnglishQ2Offer
			when "UAE Q2 Airlines"
				category_table_name = UaeQ2Airline
			when "UAE Q2 Airline Booking"
				category_table_name = UaeQ2AirlineBooking
			when "UAE Q2 Generic"
				category_table_name = UaeQ2Generic	
			when "Testing KSA"
				table_name = TestingKsa
			when "Temporary"
				table_name = Temporary
			else
				category_table_name = ""			
			end
		end
	end
