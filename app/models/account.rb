class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :branch_office
  has_many :transactions

  delegate :name, to: :owner, prefix: true

  after_create :assign_account_number, :activate!

  scope :active, -> { where(closed_on: nil) }

  class << self
    def aperture(owner:, branch_office:)
      Account.create(balance: 0.00, owner: owner, branch_office: branch_office)
    end
  end

  def deposit(amount)
    raise Exceptions::AccountClosed if closed?
    raise Exceptions::InvalidAmount if amount < 0

    update(balance: balance + amount.floor(2))
    balance
  end

  def withdraw(amount)
    amount = amount.floor(2)
    raise Exceptions::AccountClosed if closed?
    raise Exceptions::InvalidAmount if amount < 0 || amount > balance

    update(balance: balance - amount)
    balance
  end

  def close!
    update(closed_on: DateTime.now)
  end

  def account_type
    owner_type
  end

  private

  def closed?
    closed_on.present?
  end

  def active?
    activated_on.present? && closed_on.nil?
  end

  def assign_account_number
    update(account_number: id)
  end

  def activate!
    update(activated_on: DateTime.now)
  end
end
