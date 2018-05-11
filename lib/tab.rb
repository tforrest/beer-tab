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

      if tab.count.zero?
        return false
      end
      tab.count -= 1
      tab.save
      true
    end

    def ensure_tab(owes_id, owed_id)
      Tab.find_or_create_by!(owes: owes_id,
                             owed: owed_id)
    end

    def show_owed(owed_id)
      Tab.find_by(owed: owed_id).sum(:count)
    end

    def show_owes(owes_id)
      Tab.find_by(owes: owes_id).sum(:count)
    end

    def ensure_user(user)
      User.find_or_create_by!(telegram_id: user.id,
                              first_name: user.first_name,
                              last_name: user.last_name,
                              username: user.username)

    end
  end
end