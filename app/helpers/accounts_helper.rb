module AccountsHelper
  def present_event(account)
    date = Date.today
    {
      "0" => Event.find_by_date(date, account),
      "1" => Event.find_by_date(date + 1, account),
      "2" => Event.find_by_date(date + 2, account),
      "3" => Event.find_by_date(date +3, account),
      "4" => Event.find_by_date(date + 4, account),
      "5" => Event.find_by_date(date + 5, account),
      "6" => Event.find_by_date(date + 6, account),
      "7" => Event.find_by_date(date + 7, account)
    }
  end
end
