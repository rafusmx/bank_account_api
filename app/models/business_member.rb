class BusinessMember < ApplicationRecord
  belongs_to :business
  belongs_to :person
end
