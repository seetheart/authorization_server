class BaseService
  include ActiveModel::Validations

  def error_status
    @error_status ||= 400
  end

  def error_code
    @error_code ||= "INVALID"
  end
end
