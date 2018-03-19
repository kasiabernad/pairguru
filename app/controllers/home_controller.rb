class HomeController < ApplicationController
  def welcome; end

  def top_commenters
    @beginning_of_week = 7.days.ago.utc.beginning_of_day.strftime('%d %b %Y')
    @end_of_week = Time.zone.now.strftime('%d %b %Y')
    @top_commenters = User.joins(:comments)
                          .where('comments.created_at >= ?', @beginning_of_week)
                          .group('comments.user_id')
                          .order("count(*) desc")
                          .limit(10)
  end
end
