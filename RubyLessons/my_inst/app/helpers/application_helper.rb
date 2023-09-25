module ApplicationHelper
  def to_date_format(date)
    date.strftime('%d.%m.%Y %H:%M')
  end
end
