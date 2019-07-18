# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_18_074217) do

  create_table "aeq1_hotels_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emirates_uae_campaigns", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flight_india_q2s", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "india_flights", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "india_hotels", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksa_arabic_q2s", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksa_english_q2_airlines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksa_english_q2_bookings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksa_english_q2_generics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksa_english_q2_offers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksaq1_arabic_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history", limit: 16777215
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksaq1_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history", limit: 16777215
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uae_q2_airline_bookings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uae_q2_airlines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uae_q2_generics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "category_name"
    t.string "string"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language"
    t.string "region"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url"
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uaeq1_activities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name", collation: "latin1_swedish_ci"
    t.integer "keyword_id"
    t.string "url", collation: "latin1_swedish_ci"
    t.string "keyword", collation: "latin1_swedish_ci"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type", collation: "latin1_swedish_ci"
    t.string "search_type", collation: "latin1_swedish_ci"
    t.string "exact_url_tracked", collation: "latin1_swedish_ci"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history", collation: "latin1_swedish_ci"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite", collation: "latin1_swedish_ci"
    t.string "day_change", collation: "latin1_swedish_ci"
    t.string "week_change", collation: "latin1_swedish_ci"
    t.string "month_change", collation: "latin1_swedish_ci"
    t.string "life_change", collation: "latin1_swedish_ci"
    t.string "ranking_url", collation: "latin1_swedish_ci"
    t.string "seo_compete_pages", collation: "latin1_swedish_ci"
    t.integer "search_volume"
    t.string "tags", collation: "latin1_swedish_ci"
    t.string "featured_url", limit: 250
    t.string "last_update", collation: "latin1_swedish_ci"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uaeq1_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name", collation: "latin1_swedish_ci"
    t.integer "keyword_id"
    t.string "url", collation: "latin1_swedish_ci"
    t.string "keyword", collation: "latin1_swedish_ci"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type", collation: "latin1_swedish_ci"
    t.string "search_type", collation: "latin1_swedish_ci"
    t.string "exact_url_tracked", collation: "latin1_swedish_ci"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history", collation: "latin1_swedish_ci"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite", collation: "latin1_swedish_ci"
    t.string "day_change", collation: "latin1_swedish_ci"
    t.string "week_change", collation: "latin1_swedish_ci"
    t.string "month_change", collation: "latin1_swedish_ci"
    t.string "life_change", collation: "latin1_swedish_ci"
    t.string "ranking_url", collation: "latin1_swedish_ci"
    t.string "seo_compete_pages", collation: "latin1_swedish_ci"
    t.integer "search_volume"
    t.string "tags", collation: "latin1_swedish_ci"
    t.string "featured_url", limit: 250
    t.string "last_update", collation: "latin1_swedish_ci"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visas", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.integer "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "language", limit: 10
    t.string "region", limit: 50
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.integer "kw_start_position"
    t.integer "target_position"
    t.integer "google_page"
    t.integer "google_rank"
    t.text "google_rank_history"
    t.integer "bing_rank"
    t.integer "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.integer "search_volume"
    t.string "tags"
    t.string "featured_url", limit: 250
    t.string "last_update"
    t.integer "quater_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
