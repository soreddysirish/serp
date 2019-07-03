class DetailsController < ApplicationController

	def dashboard
		categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
		categories_keys = categories_list.keys
		@categories = {"AE Q1 Hotels Keywords":{},"Emirates - UAE Campaign":{},"India Flights":{},"India Hotels":{},"KSA Q1 Arabic Keywords":{},"KSA Q1 Keywords":{},"UAE Q1 Activities":{},"UAE Q1 Keywords":{},"Visa":{}}
		categories_list = []
		cat_obj ={}
		categories_keys.each_with_index do |model,index|
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
			obj = {}
			@rank_one_keywords = table_name.where(google_rank: 1)
			@rank_in_between_two_and_three = table_name.where(google_rank: 2..3)
			@rank_in_between_four_and_ten = table_name.where(google_rank: 4..10)
			@rank_in_between_ten_and_twenty = table_name.where(google_rank: 4..10)
			@rank_above_twenty = table_name.where("google_rank > ?",20 )
			@categories["#{model}"] = {"rank_one_keywords" => @rank_one_keywords.count,
				"rank_in_between_two_and_three" => @rank_in_between_two_and_three.count,
				"rank_in_between_four_and_ten"=>@rank_in_between_four_and_ten.count,
				"rank_in_between_ten_and_twenty"=>@rank_in_between_ten_and_twenty.count,
				"rank_above_twenty"=>@rank_above_twenty.count}
				categories_list << model
			end
			list = {}
			list["categories_keys"] = categories_list
			list["categories_data"] = @categories
			render json: list
		end
		def fetch_details
			@category_name = params[:category_name]
			categories_list  = HTTParty.get("https://serpbook.com/serp/api/?action=getcategories&auth=d3f28ee6533cfffa743ce5630ca35600")
			categories_keys = categories_list.keys
			category_exist = categories_keys.include?(@category_name)
			if category_exist
				case @category_name
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
				@rank_one_keywords = table_name.where(google_rank: 1)
				@rank_in_between_two_and_three = table_name.where(google_rank: 2..3)
				@rank_in_between_four_and_ten = table_name.where(google_rank: 4..10)
				@rank_in_between_ten_and_twenty = table_name.where(google_rank: 4..10)
				@rank_above_twenty = table_name.where("google_rank > ?",20 )
			end

		end
	end
