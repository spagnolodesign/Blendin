module ApplicationHelper

  def current_class?(test_path)
    return 'active-topnav-link' if request.path == test_path
    ''
  end

end
