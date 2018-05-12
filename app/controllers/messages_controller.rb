# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_admin!

  def messages
    @messages = Message.limit(100).order('id desc')
    render json: @messages
  end

  def company_messages
    @messages = Message.find_by(company_id: params[:id])
    render json: @messages
  end

  def guard_messages
    @messages = Message.find_by(guardian_id: params[:id])
    render json: @messages
  end

  def alarm_messages
    @messages = Message.find_by(alarm_id: params[:id])
    render json: @messages
  end

  def user_messages
    @messages = Message.find_by(user_id: params[:id])
    render json: @messages
  end
end
