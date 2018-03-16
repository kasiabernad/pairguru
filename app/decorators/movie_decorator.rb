class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    Typhoeus.get("https://pairguru-api.herokuapp.com/#{poster}").effective_url
  end

  def plot
    object.additional_info['data']['attributes']['plot']
  end

  def rating
    object.additional_info['data']['attributes']['rating']
  end

  def poster
    object.additional_info['data']['attributes']['poster']
  end
end
