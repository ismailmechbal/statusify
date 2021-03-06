# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20_151_018_143_607) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'delayed_jobs', force: :cascade do |t|
    t.integer 'priority',   default: 0, null: false
    t.integer 'attempts',   default: 0, null: false
    t.text 'handler',                null: false
    t.text 'last_error'
    t.datetime 'run_at'
    t.datetime 'locked_at'
    t.datetime 'failed_at'
    t.string 'locked_by'
    t.string 'queue'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'delayed_jobs', %w(priority run_at), name: 'delayed_jobs_priority', using: :btree

  create_table 'events', force: :cascade do |t|
    t.string 'message'
    t.string 'status'
    t.integer 'incident_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'events', ['incident_id'], name: 'index_events_on_incident_id', using: :btree

  create_table 'incidents', force: :cascade do |t|
    t.string 'name'
    t.string 'component'
    t.string 'status'
    t.boolean 'public', default: true
    t.datetime 'created_at',                null: false
    t.datetime 'updated_at',                null: false
    t.boolean 'active', default: true
    t.integer 'user_id'
    t.string 'severity'
  end

  add_index 'incidents', ['active'], name: 'index_incidents_on_active', using: :btree
  add_index 'incidents', ['created_at'], name: 'index_incidents_on_created_at', using: :btree
  add_index 'incidents', ['id'], name: 'index_incidents_on_id', using: :btree
  add_index 'incidents', ['user_id'], name: 'index_incidents_on_user_id', using: :btree

  create_table 'subscribers', force: :cascade do |t|
    t.string 'email'
    t.boolean 'activated', default: false
    t.string 'activation_key'
    t.datetime 'created_at',                     null: false
    t.datetime 'updated_at',                     null: false
  end

  add_index 'subscribers', ['activated'], name: 'index_subscribers_on_activated', using: :btree

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at',                                     null: false
    t.datetime 'updated_at',                                     null: false
    t.string 'email',                                          null: false
    t.string 'encrypted_password', limit: 128,                 null: false
    t.string 'confirmation_token', limit: 128
    t.string 'remember_token',     limit: 128, null: false
    t.boolean 'admin', default: false
  end

  add_index 'users', ['email'], name: 'index_users_on_email', using: :btree
  add_index 'users', ['remember_token'], name: 'index_users_on_remember_token', using: :btree
end
