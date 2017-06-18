module ApplicationHelper

  def bootstrap_class_for flash_type
    {
      "success" => "alert-success",
      "error" => "alert-danger",
      "alert" => "alert-warning",
      "notice" => "alert-info",
      "recaptcha_error" => "alert-danger",
    }[flash_type]
  end

  def display_name(customer)
      capitalize_name "#{customer.firstname} #{customer.lastname}"
  end

  def capitalize_name name
    names = []
    unless name.blank?
      name.split.each do |n|
        names << n.split('-').map(&:capitalize).join('-')
      end
    end
    names.join(' ')
  end
end
