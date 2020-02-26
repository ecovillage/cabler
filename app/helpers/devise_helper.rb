module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| msg + content_tag(:br)}.join
    return flash.now[:warning] = messages.html_safe
  end
end