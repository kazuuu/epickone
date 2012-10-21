class AdminController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def draws
  end
  def admin
  end
end
