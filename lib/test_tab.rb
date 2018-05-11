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
    owes = create_mock_user(10, 'bob', 'meme', 'memebob')

    BeerTab.ensure_user(owes)
    u = User.find_by telegram_id: 10
    assert_equal(10, u.telegram_id, 'telegram id should be 10')
  end

  def test_ensure_tab
    owes_id = 0
    owed_id = 1
    BeerTab.ensure_tab(owes_id, owed_id)
    t = Tab.where(['owes = ?  and owed = ?', owes_id, owed_id]).take!
    assert_equal(t.owes, owes_id, 'telegram id should be 0')
    assert_equal(t.owed, owed_id, 'telegram id should be 1')
    assert_equal(0, t.count, 'Count of this tab should be 0')
  end

  def test_increment_tab
    owes = create_mock_user(2, 'bob', 'bill', 'bb')
    owed = create_mock_user(3, 'tim', 'tony','tt')

    BeerTab.add_to_tab(owes, owed)
    BeerTab.add_to_tab(owes, owed)
    BeerTab.add_to_tab(owes, owed)

    t = Tab.where(['owes = ?  and owed = ?', owes.id, owed.id]).take!

    assert_equal(3, t.count, 'Count of this tab should be 3')

  end

  def create_mock_user(id, first, last, username)
    user = MockUser.new
    user.id = id
    user.first_name = first
    user.last_name = last
    user.username = username
    user
  end
end
