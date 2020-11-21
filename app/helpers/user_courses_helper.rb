module UserCoursesHelper
  def status_badges status = "all"
    badges = case status.to_sym
             when :learning
               "primary"
             when :pending
               "warning"
             when :finish
               "success"
             when :not_allowed
               "danger"
             else
               "secondary"
             end
    content_tag(:span,
                I18n.t("status.#{status}"),
                class: ["badge", "badge-#{badges}"])
  end

  def status_filter
    data = []
    data << (link_to my_courses_path, remote: true do
               status_badges
             end)
    UserCourse.statuses.keys.each do |status|
      data << (link_to my_courses_path(status: status), remote: true do
                 status_badges status
               end)
    end
    safe_join data
  end
end
