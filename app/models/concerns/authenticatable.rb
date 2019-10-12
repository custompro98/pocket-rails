module Authenticatable
  def owned_by?(user, ids)
    unless where(id: ids).all? { |resource| resource.user_id == user.id }
      raise ::ExceptionHandler::ResourceForbidden.new("#{self.name} is owned by a different user")
    end
  end
end