class Participant < ApplicationRecord
  belongs_to :event
  belongs_to :account
  validate :only_one, :is_creator, :check_capacity, :on => :create

  def self.exists?(event, current_user)
    Participant.find_by(event: event, account: current_user)
  end

  private

  def is_creator
    if account==event.creator
      errors.add(:event, " error: You are the creator of this event")
    end
  end

  def only_one
    exists = Participant.find_by(event: event, account: account)
    if exists
      errors.add(:event, " error: You've already RSVP'd")
    end
  end

  def check_capacity
    if Participant.where(event: event).count >= event.capacity
      errors.add(:event, " error: This event is at full capacity.")
    end
  end

end
