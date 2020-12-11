class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :update, User, id: user.id
      can :create, UserCourse
      can :read, CourseLecture, course_id: user.user_courses
                                               .learning
                                               .pluck(:course_id)
    end
  end
end
