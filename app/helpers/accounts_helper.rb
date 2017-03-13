module AccountsHelper
  def present_event(account)
    date = Date.today
    {
      today: Event.find_by_date(date, account),
      tomorrow: Event.find_by_date(date + 1, account),
      day_after_that: Event.find_by_date(date + 2, account),
      day_after_after_that: Event.find_by_date(date +3, account)
    }
  end
end
