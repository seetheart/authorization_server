class AuthorizeService < BaseService
  attr_reader :result

  def initialize(params)
    @role_name = params[:role_name]
    @action_name = params[:action_name]
    @app_name = params[:application_name]
    @authorized = true
  end

  def perform
    app = Application.find_by_name(@app_name)
    return errors.add(:base, "application_id: #{id} does not exist") && false unless app

    role = app.roles.where(name: @role_name)
    return errors.add(:base, "role_id: #{id} does not exist") && false unless role

    unless Permission.where(role: role).map(&:action).include?(@action_name)
      @authorized = false
    end

    true
  end

  def result
    @result ||= { authorized: @authorized}
  end
end
