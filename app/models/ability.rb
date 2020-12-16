class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    cannot :read, :my_courses
    if user.admin?
      can :manage, :all
    elsif User.exists? user.id
      can :update, User, id: user.id
      can :create, UserCourse
      can :read, CourseLecture, course_id: user.user_courses
                                               .by_status(%w(learning finish))
                                               .pluck(:course_id)
      can :read, :my_courses
    end
  end
end
