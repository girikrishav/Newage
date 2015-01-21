include ActiveAdminHelpers

ActiveAdmin.register_page "Profile" do
  menu :if => proc {menu_accessible?("User")}, :parent => "Security", :priority => 10

  controller do
    before_filter do |c|
      c.send(:is_user_authorized?, "User", url_for)
      redirect_to edit_admin_user_path(:id => current_admin_user.id)
    end
  end

  content do
  end
end