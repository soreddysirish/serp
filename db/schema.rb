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

ActiveRecord::Schema.define(version: 2019_07_02_095009) do

  create_table "aeq1_hotels_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emirates_uae_campaigns", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "india_flights", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "india_hotels", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksaq1_arabic_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ksaq1_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uaeq1_activities", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uaeq1_keywords", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visas", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category_name"
    t.string "keyword_id"
    t.string "url"
    t.string "keyword"
    t.string "type"
    t.string "search_type"
    t.string "exact_url_tracked"
    t.string "kw_start_position"
    t.string "google_rank"
    t.text "google_rank_history"
    t.string "bing_rank"
    t.string "yahoo_rank"
    t.string "is_favorite"
    t.string "day_change"
    t.string "week_change"
    t.string "month_change"
    t.string "life_change"
    t.string "ranking_url"
    t.string "seo_compete_pages"
    t.string "search_volume"
    t.string "tags"
    t.string "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
