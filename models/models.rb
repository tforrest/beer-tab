require 'active_record'

class User < ActiveRecord::Base
end

class Tab < ActiveRecord::Base
end


def create_user_table
  ActiveRecord::Schema.define do
    create_table :users, id: false, force: :cascade do |t|
      t.integer 'telegram_id', primary_key: true, null: false
      t.string 'first_name'
      t.string 'last_name'
      t.string 'username', null: false
    end
  end
end

def create_tab_table
  ActiveRecord::Schema.define do
    create_table :tabs, id: false do |t|
      t.integer 'count', default: 0
      t.integer 'owes', null: false, references: :user
      t.integer 'owed',  null: false, references: :user
      t.primary_key 'owes', 'owed'
      t.timestamp
    end
  end
end