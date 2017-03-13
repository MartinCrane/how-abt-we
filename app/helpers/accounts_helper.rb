module AccountsHelper
  def present_event(account)
    date = Date.today
    {
      blah: Event.find_by_date(date, account),
      bloo: Event.find_by_date(date + 1, account),
      blee: Event.find_by_date(date + 2, account),
      blow: Event.find_by_date(date +3, account)
    }
  end
end
