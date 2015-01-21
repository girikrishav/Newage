include ActiveAdminHelpers

ActiveAdmin.register_page "Security" do
  menu :if => proc { menu_accessible?("User") }, :priority => 10

  controller do
    before_filter do |c|
      c.send(:is_user_authorized?, "User", url_for)
      redirect_to admin_profile_path
    end
  end

  content do
  end
end