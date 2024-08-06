module AccountOwner
  extend ActiveSupport::Concern

  included do
    has_many :accounts, as: :owner
  end

  def name
    raise NotImplementedError
  end
end
