require 'rake/testtask'
require 'active_record'
require 'sqlite3'

namespace 'test' do
  task :unittest do
    Rake::TestTask.new do |t|
      t.libs << 'test'
      t.test_files = FileList['test/*']
    end
  end
end


namespace 'db' do
  desc 'setup sqlite3 in-memory database'
  task :setup_sqlite3 do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'beerlite')
  end

  desc 'create database schema'
  task :create_tables do
    Rake::Task['db:setup_sqlite3'].invoke
    ActiveRecord::Schema.define do
      create_table :user, force: :cascade do |t|
        t.integer 'telegram_id', :primary_key, null: false
        t.string 'first_name'
        t.string 'last_name'
        t.string 'username', null: false
      end
    end
    ActiveRecord::Schema.define do
      create_table :tab do |t|
        t.integer 'count', default: 0
        t.integer 'owes', :primary_key, null: false, references: :user
        t.integer 'owed', :primary_key, null: false, references: :user
        t.timestamp
      end
    end
  end
end
