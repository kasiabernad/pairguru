class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    Typhoeus.get("https://pairguru-api.herokuapp.com/#{poster}").effective_url
  end

  def plot
    object.additional_info['data']['attributes']['plot'] if object.additional_info
  end

  def rating
    object.additional_info['data']['attributes']['rating'] if object.additional_info
  end

  def poster
    object.additional_info['data']['attributes']['poster'] if object.additional_info
  end
end
