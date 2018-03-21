class CommentDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime('%d %b %Y %H:%M')
  end
end
