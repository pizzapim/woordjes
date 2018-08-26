class ApplicationController < ActionController::Base

  before_action do
    I18n.locale = params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected
  def after_sign_in_path_for(resource)
    lists_path
  end

  def after_sign_up_path_for(resource)
    lists_path
  end

  def after_sign_out_path_for(resource)
    home_path locale: I18n.locale
  end
end
