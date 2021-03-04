class ApplicationController < ActionController::Base
  # before_action :処理させたいメソッド名 if:オプション trueの場合実行される
  # これによりdeviseに関するコントローラーの処理であればそのときだけ当メソッドは実行される。
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end