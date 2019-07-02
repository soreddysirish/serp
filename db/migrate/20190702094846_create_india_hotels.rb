class CreateIndiaHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :india_hotels do |t|
      t.string :category_name
      t.string :keyword_id
      t.string :url
      t.string :keyword
      t.string :type
      t.string :search_type
      t.string :exact_url_tracked
      t.string :kw_start_position
      t.string :google_rank
      t.text :google_rank_history
      t.string :bing_rank
      t.string :yahoo_rank
      t.string :is_favorite
      t.string :day_change
      t.string :week_change
      t.string :month_change
      t.string :life_change
      t.string :ranking_url
      t.string :seo_compete_pages
      t.string :search_volume
      t.string :tags
      t.string :last_update

      t.timestamps
    end
  end
end
