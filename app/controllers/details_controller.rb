class DetailsController < ApplicationController

	def dashboard
		categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
		categories_keys = categories_list.keys
		@categories = {"AE Q1 Hotels Keywords":{},"Emirates - UAE Campaign":{},"India Flights":{},"India Hotels":{},"KSA Q1 Arabic Keywords":{},"KSA Q1 Keywords":{},"UAE Q1 Activities":{},"UAE Q1 Keywords":{},"Visa":{}}
		categories_list = []
		cat_obj ={}
		categories_keys.each_with_index do |key,index|
			table_name = get_table_name(key)
			obj = {}
			@rank_one_keywords = table_name.where(google_rank: 1) rescue []
			@rank_in_between_two_and_three = table_name.where(google_rank: 2..3) rescue []
			@rank_in_between_four_and_ten = table_name.where(google_rank: 4..10) rescue []
			@rank_in_between_ten_and_twenty = table_name.where(google_rank: 10..20) rescue []
			@rank_above_twenty = table_name.where("google_rank > ?",20 ) rescue []
			@categories["#{key}"] = {"rank_one_keywords" => @rank_one_keywords.count,
				"rank_in_between_two_and_three" => @rank_in_between_two_and_three.count,
				"rank_in_between_four_and_ten"=>@rank_in_between_four_and_ten.count,
				"rank_in_between_ten_and_twenty"=>@rank_in_between_ten_and_twenty.count,
				"rank_above_twenty"=>@rank_above_twenty.count}
				categories_list << key
			end
			list = {}
			list["categories_keys"] = categories_list
			list["categories_data"] = @categories
			render json: list
		end

		def category_details
			@category_name = params[:category_name].split("_").join(" ")
			categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
			categories_keys = categories_list.keys
			category_exist = categories_keys.include?(@category_name)
			column_headings = []
			table_headings = {"category_name" => "Category Name","tags" => "Tag","keyword" => "Keyword","start_date" => "Start Date","current_date" => "Current Date","percentage" => "Percentage"}
			if category_exist
				table_name = get_table_name(@category_name)
				keywords = table_name.all.pluck(:keyword).uniq
				category_details_obj = []
				start_date_ranks = {"mobile_rank"=> "","desktop_rank" => ""}
				current_date_ranks = {"mobile_rank"=> "","desktop_rank" => ""}
				keywords.each do |kw|
				start_date_records = table_name.where("keyword=? and Date(created_at) = ?",kw, "2019-07-02")
				first_record  = start_date_records.first
				category_name = first_record.category_name
				tag = first_record.tags
				keyword = first_record.keyword

				start_date_records.each do |sr|
					if sr.search_type == "sem"
						start_date_ranks["mobile_rank"] = sr.google_rank
					else
						start_date_ranks["desktop_rank"] = sr.google_rank
					end

				end
					current_date_records = table_name.where("keyword=? and Date(created_at) = ? ",kw, Date.today.to_s(:db))
					current_date_records.each do |cr|
						if cr.search_type == "sem"
							current_date_ranks["mobile_rank"] = cr.google_rank	
						else
							current_date_ranks["desktop_rank"] = cr.google_rank
						end
					end
					if start_date_ranks["mobile_rank"] != 0 && start_date_ranks["desktop_rank"] != 0
						mobile_rank_percentage = ((start_date_ranks["mobile_rank"] - current_date_ranks["mobile_rank"])/start_date_ranks["mobile_rank"])*100
						desktop_rank_percentage = ((start_date_ranks["desktop_rank"] - current_date_ranks["desktop_rank"])/start_date_ranks["desktop_rank"])*100
					end
					percentage = {}
					percentage["desktop_rank_percentage"] = desktop_rank_percentage rescue 0 
					percentage["mobile_rank_percentage"] = mobile_rank_percentage rescue 0 
					category_details_obj << {"category_name" => category_name,"tags" => tag,"keyword" => keyword,"start_date_ranks" =>start_date_ranks,"current_date_ranks" => current_date_ranks,"percentage" => percentage }

					# mobile_start_date_records = table_name.where("keyword=? and Date(created_at) = ? and search_type='sem'",kw, "2019-07-02")
					# mobile_current_date_records = table_name.where("keyword=? and Date(created_at) = ?  and search_type='sem'", Date.today.to_s(:db))
				end
			
				start_date = eval(table_name.group(:keyword).first.last_update)["date"]
				current_date = Date.today.to_formatted_s(:long_ordinal)
				table_columns = table_name.column_names
				table_columns.push("start_date","current_date")
				heading_obj = {}
				table_columns.each do |tc|
					if table_headings["#{tc}"].present?  
					heading_obj = {"accessor" => "#{tc}","heading" => table_headings["#{tc}"]}
					column_headings << heading_obj
					end
				end
			end
			binding.pry
			render json: {category_details_obj:  category_details_obj,headings: column_headings}
		end

		def overall_categories_view
			categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
			categories_keys = categories_list.keys
			@categories = {"AE Q1 Hotels Keywords":{},"Emirates - UAE Campaign":{},"India Flights":{},"India Hotels":{},"KSA Q1 Arabic Keywords":{},"KSA Q1 Keywords":{},"UAE Q1 Activities":{},"UAE Q1 Keywords":{},"Visa":{}}
		categories_list = []
		cat_obj ={}
		category_name = ""
		start_date_total_keywords = {}
		current_date_total_keywords = {}

		categories_keys.each_with_index do |key,index|
			category_name = key
			category_table_name = get_table_name(key)
			start_date = "2019-07-02"
			current_date =  Date.today.to_s(:db)
			# total_keywords = category_table_name.all.map{|r| r.keyword}.uniq
			# total_keywords_count = total_keywords.count
			start_date_total_keywords["top_1"] = category_table_name.where("google_rank=? and Date(created_at)=?",1,"#{start_date}") rescue []
			start_date_total_keywords["top_2_3"] = category_table_name.where("google_rank=? and Date(created_at)=?",2..3,"#{start_date}") rescue []

			start_date_total_keywords["top_4_10"] = category_table_name.where("google_rank=? and Date(created_at)=?",4..10,"#{start_date}").count rescue []
			start_date_total_keywords["rank_above_10"] = category_table_name.where("google_rank > ? and Date(created_at)",10 ,"#{start_date}").count rescue []
			current_date_total_keywords["rank_1"] = category_table_name.where("google_rank=? and Date(created_at)=?",1,"#{current_date}").count rescue []
			current_date_total_keywords["rank_2_3"] = category_table_name.where("google_rank=? and Date(created_at)=?",2..3,"#{current_date}").count rescue []
			current_date_total_keywords["rank_4_10"] = category_table_name.where("google_rank=? and Date(created_at)=?",4..10,"#{current_date}").count rescue []
			current_date_total_keywords["rank_above_10"] = category_table_name.where("google_rank > ? and Date(created_at)",10,"#{current_date}").count rescue []
			cat_obj["category_name"] = key
			cat_obj["total_keywords"] = []
			cat_obj["count"] = 1
			cat_obj["start_date_kws"] = start_date_total_keywords
			cat_obj["current_date_kws"] = current_date_total_keywords
			categories_list << cat_obj
 			end

 			render json:  categories_list
		end
		def get_table_name(key)
			case key
			when "AE Q1 Hotels Keywords"
				category_table_name = Aeq1HotelsKeyword
			when "Emirates UAE Campaign"
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
			when "Visa"
				category_table_name = Visa
			else
				category_table_name = ""			
			end
		end
	end
