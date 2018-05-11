require 'rake/testtask'
require 'active_record'
require 'sqlite3'

require './models/models'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['./lib/test_*']
end



namespace 'db' do
  desc 'setup sqlite3 in-memory database'
  task :connect_sqlite3 do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'beerlite')
  end

  desc 'create database schema'
  task :create_tables do
    create_tab_table
    create_user_table
  end

  desc 'create sqlite3 db with schmea'
  task :setup_sqlite3_db do
    Rake::Task['db:connect_sqlite3'].invoke
    Rake::Task['db:create_tables'].invoke
  end
end
