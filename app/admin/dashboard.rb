ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Users" do
          ul do
            User.last(10).map do |user|
              li link_to(user.name, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Users"
          span "All Users: " + User.count.to_s
          br
          span "Total new comers: " + User.where(local:false).count.to_s
          br
          span "Total locals: " + User.where(local:true).count.to_s
          br
          br
          para "Blends"
          span "Total blend request: " + Blend.count.to_s
          br
          span "Total blend accepted: " + Blend.where(status:'accepted').count.to_s
          br
          span "Total blend declined: " + Blend.where(status:'declined').count.to_s
          br
          span "Total blend pending: " + Blend.where(status:'pending').count.to_s
        end
      end
    end
  end # content
end
