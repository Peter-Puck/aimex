# :nodoc:
module ApplicationHelper
  def left_menu
    left_menu_entries((current_user.is_admin == true) ? admin_left_menu_content: left_menu_content)
  end

  private

  def selected_locale
    locale = FastGettext.locale
    locale_list.detect {|entry| entry[:locale] == locale}
  end

  def locale_list
    [
      {
        flag: 'us',
        locale: 'en',
        name: 'English (US)',
        alt_name: 'United States'
      },
      {
        flag: 'fr',
        locale: 'fr',
        name: 'Français',
        alt_name: 'France'
      },
      {
        flag: 'es',
        locale: 'es',
        name: 'Español',
        alt_name: 'Spanish'
      },
      {
        flag: 'de',
        locale: 'de',
        name: 'Deutsch',
        alt_name: 'German'
      },
      {
        flag: 'jp',
        locale: 'ja',
        name: '日本語',
        alt_name: 'Japan'
      },
      {
        flag: 'cn',
        locale: 'zh',
        name: '中文',
        alt_name: 'China'
      },
      {
        flag: 'it',
        locale: 'it',
        name: 'Italiano',
        alt_name: 'Italy'
      },
      {
        flag: 'pt',
        locale: 'pt',
        name: 'Portugal',
        alt_name: 'Portugal'
      },
      {
        flag: 'ru',
        locale: 'ru',
        name: 'Русский язык',
        alt_name: 'Russia'
      },
      {
        flag: 'kr',
        locale: 'kr',
        name: '한국어',
        alt_name: 'Korea'
      },
    ]
  end

  def left_menu_entries(entries = [])
    output = ''
    entries.each do |entry|
      children_selected = entry[:children] &&
        entry[:children].any? {|child| current_page?(child[:href]) }
      entry_selected =  current_page?(entry[:href])
      li_class =
      case
        when children_selected
          'open'
        when entry_selected
          'active'
      end
      output +=
        content_tag(:li, class: li_class) do
          subentry = ''
          subentry +=
            link_to entry[:href], title: entry[:title], class: entry[:class], target: entry[:target] do
              link_text = ''
              link_text += entry[:content].html_safe
              if entry[:children]
                if children_selected
                  link_text += '<b class="collapse-sign"><em class="fa fa-minus-square-o"></em></b>'
                else
                  link_text += '<b class="collapse-sign"><em class="fa fa-plus-square-o"></em></b>'
                end
              end

              link_text.html_safe
            end
          if entry[:children]
            if children_selected
              ul_style = 'display: block'
            else
              ul_style = ''
            end
            subentry +=
              "<ul style='#{ul_style}'>" +
                left_menu_entries(entry[:children]) +
                "</ul>"
          end

          subentry.html_safe
        end
    end
    output.html_safe
  end

  def admin_left_menu_content
    [
      {
        href: new_user_url,
        content: 	   "<i class='fa fa-lg fa-fw fa-user'></i> <span class='menu-item-parent'>" + _('Users') + "</span>" 
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-cloud'><em>3</em></i> <span class='menu-item-parent'>" + _('Cool Features!') + "</span>",
        children: [
          {
            href: cool_features_calendar_path,
            content: "<i class='fa fa-lg fa-fw fa-calendar'></i> <span class='menu-item-parent'>" + _('Calendar') + "</span>"
          },
          {
            href: cool_features_gmap_skins_path,
            content: "<i class='fa fa-lg fa-fw fa-map-marker'></i> <span class='menu-item-parent'>" + _('GMap Skins') + "</span><span class='badge bg-color-greenLight pull-right inbox-badge'>9</span>"
          },
        ]
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-puzzle-piece'></i> <span class='menu-item-parent'>" + _('App Views') + "</span>",
        children: [
          {
            href: app_views_projects_path,
            content: "<i class='fa fa-file-text-o'></i> " + _('Projects') + ""
          },
          {
            href: app_views_blog_path,
            content: "<i class='fa fa-paragraph'></i> " + _('Blog') + ""
          },
          {
            href: app_views_gallery_path,
            content: "<i class='fa fa-picture-o'></i> " + _('Gallery') + ""
          },
          {
            href: '#',
            content: "<i class='fa fa-comments'></i> " + _('Forum Layout') + "",
            children: [
              {
                href: app_views_forum_layout_general_view_path,
                content: _('General View')
              },
              {
                href: app_views_forum_layout_topic_view_path,
                content: _('Topic View')
              },
              {
                href: app_views_forum_layout_post_view_path,
                content: _('Post View')
              },

            ]
          },
          {
            href: app_views_profile_path,
            content: "<i class='fa fa-group'></i> " + _('Profile') + ""
          },
          {
            href: app_views_timeline_path,
            content: "<i class='fa fa-clock-o'></i> " + _('Timeline') + ""
          },
          {
            href: app_views_search_page_path,
            content: "<i class='fa fa-search'></i>  " + _('Search Page') + ""
          },
        ]
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-shopping-cart'></i> <span class='menu-item-parent'>" + _('E-Commerce') + "</span>",
        children: [
          {
            href: e_commerce_orders_path,
            content: _('Orders')
          },
          {
            href: e_commerce_products_view_path,
            content: _('Products View')
          },
          {
            href: e_commerce_products_detail_path,
            content: _('Products Detail')
          },
        ]
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-windows'></i> <span class='menu-item-parent'>" + _('Miscellaneous') + "</span>",
        children: [
          {
            href: miscellaneous_pricing_tables_path,
            content: _('Pricing Tables')
          },
          {
            href: miscellaneous_invoice_path,
            content: _('Invoice')
          },
          {
            href: miscellaneous_login_path,
            content: _('Login')
          },
          {
            href: miscellaneous_register_path,
            content: _('Register')
          },
       #   {
       #    href: new_password_path(resource_name),
       #     content: _('Forgot Password')
       #   },
          {
            href: miscellaneous_locked_screen_path,
            content: _('Locked Screen')
          },
          {
            href: miscellaneous_error_404_path,
            content: _('Error 404')
          },
          {
            href: miscellaneous_error_500_path,
            content: _('Error 500')
          },
          {
            href: miscellaneous_blank_page_path,
            content: _('Blank Page')
          },
        ]
      },
    ]
  end


  def left_menu_content
    [

      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-cloud'><em>3</em></i> <span class='menu-item-parent'>" + _('Cool Features!') + "</span>",
        children: [
          {
            href: cool_features_calendar_path,
            content: "<i class='fa fa-lg fa-fw fa-calendar'></i> <span class='menu-item-parent'>" + _('Calendar') + "</span>"
          },
          {
            href: cool_features_gmap_skins_path,
            content: "<i class='fa fa-lg fa-fw fa-map-marker'></i> <span class='menu-item-parent'>" + _('GMap Skins') + "</span><span class='badge bg-color-greenLight pull-right inbox-badge'>9</span>"
          },
        ]
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-puzzle-piece'></i> <span class='menu-item-parent'>" + _('App Views') + "</span>",
        children: [
          {
            href: app_views_projects_path,
            content: "<i class='fa fa-file-text-o'></i> " + _('Projects') + ""
          },
          {
            href: app_views_blog_path,
            content: "<i class='fa fa-paragraph'></i> " + _('Blog') + ""
          },
          {
            href: app_views_gallery_path,
            content: "<i class='fa fa-picture-o'></i> " + _('Gallery') + ""
          },
          {
            href: '#',
            content: "<i class='fa fa-comments'></i> " + _('Forum Layout') + "",
            children: [
              {
                href: app_views_forum_layout_general_view_path,
                content: _('General View')
              },
              {
                href: app_views_forum_layout_topic_view_path,
                content: _('Topic View')
              },
              {
                href: app_views_forum_layout_post_view_path,
                content: _('Post View')
              },

            ]
          },
          {
            href: app_views_profile_path,
            content: "<i class='fa fa-group'></i> " + _('Profile') + ""
          },
          {
            href: app_views_timeline_path,
            content: "<i class='fa fa-clock-o'></i> " + _('Timeline') + ""
          },
          {
            href: app_views_search_page_path,
            content: "<i class='fa fa-search'></i>  " + _('Search Page') + ""
          },
        ]
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-shopping-cart'></i> <span class='menu-item-parent'>" + _('E-Commerce') + "</span>",
        children: [
          {
            href: e_commerce_orders_path,
            content: _('Orders')
          },
          {
            href: e_commerce_products_view_path,
            content: _('Products View')
          },
          {
            href: e_commerce_products_detail_path,
            content: _('Products Detail')
          },
        ]
      },
      {
        href: '#',
        content: "<i class='fa fa-lg fa-fw fa-windows'></i> <span class='menu-item-parent'>" + _('Miscellaneous') + "</span>",
        children: [
          {
            href: miscellaneous_pricing_tables_path,
            content: _('Pricing Tables')
          },
          {
            href: miscellaneous_invoice_path,
            content: _('Invoice')
          },
          {
            href: miscellaneous_login_path,
            content: _('Login')
          },
          {
            href: miscellaneous_register_path,
            content: _('Register')
          },
         # {
         #   href: new_password_path(resource_name),
         #   content: _('Forgot Password')
          #},
          {
            href: miscellaneous_locked_screen_path,
            content: _('Locked Screen')
          },
          {
            href: miscellaneous_error_404_path,
            content: _('Error 404')
          },
          {
            href: miscellaneous_error_500_path,
            content: _('Error 500')
          },
          {
            href: miscellaneous_blank_page_path,
            content: _('Blank Page')
          },
        ]
      },
    ]
  end

end
