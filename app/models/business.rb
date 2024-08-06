class Business < ApplicationRecord
  include AccountOwner

  has_many :business_members
  has_many :people, through: :business_members

  def add_member(person)
    business_members.find_or_create_by(person_id: person.id)
  end

  def remove_member(person)
    if member = business_members.find_by(person_id: person.id)
      # In a real bank you never destroy this kind of record, but time is limited
      member.destroy
    end
  end
end
