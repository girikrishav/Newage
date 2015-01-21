include ActiveAdminHelpers

ActiveAdmin.register AdminUser, :as => "User" do
  menu :if => proc { menu_accessible?("Administrator") }, :parent => "Security", :priority => 30

  config.clear_action_items!

  action_item only: [:show] do
    link_to "Cancel", admin_users_path
  end

  action_item only: [:index] do
    link_to "New User", new_admin_user_path
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
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end
  end

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :role
    default_actions
  end

  filter :email
  filter :role

  form do |f|
    f.inputs "User Details" do
      if params[:action] == "new" || params[:action] == "create"
        f.input :email
      else
        f.input :email, :input_html => {:disabled => true}
      end
      f.input :password
      f.input :password_confirmation
      if params[:id] == current_admin_user.id.to_s
        f.input :role_id, :label => 'Role', :as => :select, :collection => Role.all.map { |r| ["#{r.name}", r.id] }, :input_html => {:disabled => true}
      else
        f.input :role_id, :label => 'Role', :as => :select, :collection => Role.all.map { |r| ["#{r.name}", r.id] }
      end
    end
    f.actions
  end

end                                   
