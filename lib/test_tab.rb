require 'minitest/autorun'
require 'active_record'

require './lib/tab'
require './models/models'

# TestTab ensure the database operations are correct
class TestTab < Minitest::Test

  MockUser = Struct.new(
      :id,
      :first_name,
      :last_name,
      :username
  )
  # Create in memory database for testing
  # NEVER use anything else
  # These 3 functions should only run once
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
  create_user_table
  create_tab_table
  def after
    Tab.delete_all
    User.delete_all
  end

  def test_ensure_user
    owes = MockUser.new
    owes.id = 10
    owes.first_name = 'bob'
    owes.last_name = 'meme'
    owes.username = 'memebob'

    BeerTab.ensure_user(owes)
    u = User.find_by telegram_id: 10
    assert_equal(10, u.telegram_id)
  end

  def test_ensure_tab
    owes_id = 0
    owed_id = 1
    BeerTab.ensure_tab(owes_id, owed_id)
    t = Tab.where(['owes = ?  and owed = ?', owes_id, owed_id]).take!
    assert_equal(t.owes, owes_id)
    assert_equal(t.owed, owed_id)
    assert_equal(0, t.count)
  end
end
