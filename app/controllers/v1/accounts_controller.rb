class V1::AccountsController < ApplicationController
  def create
    account = Account.create(aperture_params)

    if account.errors.any?
      render json: { errors: account.errors.full_messages }, status: :bad_request
    else
      render json: account, status: :ok
    end
  end

  def destroy
    account = Account.find_by(id: params[:id])
    account.close!

    if account.errors.any?
      render json: { errors: account.errors.full_messages }, status: :bad_request
    else
      render json: { message: "Account #{account.id} was closed"}, status: :ok
    end
  end

  private

  def aperture_params
    params.require(:account).permit(:owner_type, :owner_id, :branch_office_id)
  end
end
