class DetailsController < ApplicationController

	def fetch_details
		@rank_one_keywords = IndiaFlight.where(google_rank: 1)
		@rank_in_between_two_and_three = IndiaFlight.where(google_rank: 2..3)
		@rank_in_between_four_and_ten = IndiaFlight.where(google_rank: 4..10)
		@rank_in_between_ten_and_twenty = IndiaFlight.where(google_rank: 4..10)
		@rank_above_twenty = IndiaFlight.where("google_rank > ?",20 )
	end
end
