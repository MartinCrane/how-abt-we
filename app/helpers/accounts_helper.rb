module AccountsHelper
  def present_event(account)
    date = Date.today
    hash={}
    i=0
    while i<8
      hash["#{i.to_s}"] = Event.find_by_date(date+i, account)
      i+=1
    end
    hash
  end

end
