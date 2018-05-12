# frozen_string_literal: true

class AppStatusController < ApplicationController
  def health
    render plain: 'I\'m ok', status: 200
  end

  def info
    render plain: 'API info page'
  end
end
