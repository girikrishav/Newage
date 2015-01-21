include ActiveAdminHelpers

ActiveAdmin.register Role do
  menu :if => proc { menu_accessible?("Administrator") }, :parent => "Security", :priority => 20

  action_item only: [:show] do
    link_to "Cancel", admin_roles_path
  end

  controller do
    before_filter do |c|
      c.send(:is_user_authorized?, "Administrator", url_for)
    end

    # To redirect create and update actions redirect to index page upon submit.
    def create
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end

    def update
      Role.delay.send_mail("giri@cognitiveclouds.com", "girikrishva@gmail.com", "Banjo", "Banjo detail.")
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end
  end
end
