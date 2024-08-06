class Person < ApplicationRecord
  include AccountOwner

  has_many :business_members
  has_many :businesses, through: :business_members

  def name
    [first_name, last_name].join(' ').titleize
  end
end
