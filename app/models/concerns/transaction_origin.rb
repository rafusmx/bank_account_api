module TransactionOrigin
  extend ActiveSupport::Concern

  included do
    has_many :transactions, as: :origin
  end

  def city
    raise NotImplementedError
  end
end
