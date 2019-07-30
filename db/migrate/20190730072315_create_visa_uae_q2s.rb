class CreateVisaUaeQ2s < ActiveRecord::Migration[5.2]
  def change
    create_table :visa_uae_q2s do |t|
      t.string :category_name
      t.string :string
      t.integer :keyword_id
      t.string :url
      t.string :keyword
      t.string :language
      t.string :region
      t.string :type
      t.string :search_type
      t.string :exact_url_tracked
      t.integer :kw_start_position
      t.integer :target_position
      t.integer :google_page
      t.integer :google_rank
      t.text :google_rank_history
      t.integer :bing_rank
      t.integer :yahoo_rank
      t.string :is_favorite
      t.string :day_change
      t.string :week_change
      t.string :month_change
      t.string :life_change
      t.string :ranking_url
      t.string :seo_compete_pages
      t.integer :search_volume
      t.string :tags
      t.string :featured_url
      t.string :last_update
      t.integer :quater_period

      t.timestamps
    end
  end
end
