class PagesController < ApplicationController
  layout false

  def landing
    @homes = Home.all.order(created_at: :asc)
  end
end
