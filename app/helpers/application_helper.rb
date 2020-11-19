module ApplicationHelper
  def page_index params_page, index, per_page
    params_page ||= 1
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def toastr_flash type
    case type
    when "danger"
      "toastr.error"
    when "success"
      "toastr.success"
    else
      "toastr.info"
    end
  end
end

def display_error object, method, name
  return unless object&.errors.present? && object.errors.key?(method)

  error = "#{name} #{object.errors.messages[method][0]}"
  content_tag :div, error, class: "error-feedback"
end
