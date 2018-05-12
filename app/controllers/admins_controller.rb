# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def companies
    @companies = Company.select('companies.*, count(guardians.id) as guardians').left_outer_joins(:guardians).group('companies.id')
    render json: @companies
  end

  def company
    @company = Company.find(params[:id])
    render json: @company
  end

  def update_company
    @company = Company.find(params[:id])

    if @company.update!(company_params)
      @company.confirm
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def create_company
    @company = Company.new(company_params)
    @company.confirm
    @company.reload
    @company.tokens = nil

    if @company.save
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :email, :password, :password_confirmation)
  end
end
