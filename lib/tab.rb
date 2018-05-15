require './models/models'

# BeerTab contains the logic to modify the tabs of beer
class BeerTab
  class << self
    def add_to_tab(owes, owed)
      ensure_user(owes)
      ensure_user(owed)

      tab = ensure_tab(owes.id, owed.id)
      tab.count += 1
      tab.save
    end

    def pay_tab(owes, owed)
      ensure_user(owes)
      ensure_user(owed)

      tab = ensure_tab(owes.id, owed.id)

      return false if tab.count.zero?

      tab.count -= 1
      tab.save
      true
    end

    def ensure_user(user)
      User.find_or_create_by!(telegram_id: user.id,
                              first_name: user.first_name,
                              last_name: user.last_name,
                              username: user.username)
    end

    def ensure_tab(owes_id, owed_id)
      Tab.find_or_create_by!(owes: owes_id,
                             owed: owed_id)
    end

    def show_owed_count(owed_id)
      Tab.where([ 'owed = ?', owed_id]).sum('count')
    end

    def show_owes_count(owes_id)
      Tab.where([ 'owes = ?', owes_id]).sum('count')
    end

    def show_tab(owed_id, owes_id)
      Tab.where(['owes = ? and owed = ?', owes_id, owed_id]).take
    end

    def show_all_owes(owes_id)
      Tab.where(owes: owes_id)
    end

    def show_all_owed(owed_id)
      Tab.where(owed: owed_id)
    end
  end
end