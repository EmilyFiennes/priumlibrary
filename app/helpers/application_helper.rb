module ApplicationHelper
  # formatting methods available for use throughout application
  def display_name(customer)
    "#{capitalize_name(customer.firstname)} #{capitalize_name(customer.lastname)}"
  end

  #We want double barrelled names to be correctly formatted
  #Ex: We want "Jean-Pierre" instead of "Jean-pierre"
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
