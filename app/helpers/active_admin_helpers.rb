module ActiveAdminHelpers
  # make this method public (compulsory)
  def self.included(dsl)
    # nothing ...
  end

  # define helper methods here ...
  def menu_accessible?(required_role)
    @current_user_rank = Role.find(current_admin_user.role_id).rank
    @required_role_rank = Role.find_by_name(required_role).rank
    if @required_role_rank > @current_user_rank
      return false
    end
    return true
  end


  def is_user_authorized?(required_role, url)
    @current_user_rank = Role.find(current_admin_user.role_id).rank
    @required_role_rank = Role.find_by_name(required_role).rank
    if params[:id] == current_admin_user.id.to_s
      return true
    end
    if @required_role_rank > @current_user_rank
      redirect_to root_path, :flash => {:error => t('messages.unauthorized', url: url)}
    end
  end

  def send_mail(from, to, subject, body, cc="", bcc="")
    Pony.mail({
                  :to => to,
                  :cc => cc,
                  :bcc => bcc,
                  :from => from,
                  :subject => subject,
                  :body => body,
                  :via => :smtp,
                  :via_options => {
                      :address => Figaro.env.gmail_address,
                      :port => Figaro.env.gmail_port,
                      :enable_starttls_auto => true,
                      :user_name => Figaro.env.gmail_username,
                      :password => Figaro.env.gmail_password,
                      :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                      :domain => "localhost.localdomain" # the HELO domain provided by the client to the server
                  }
              })
  end
end