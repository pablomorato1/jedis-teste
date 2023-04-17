module ApplicationHelper
  def render_paginate(collection, size)
    return unless collection.present?
    if size == "small"
      will_paginate collection, :inner_window => 1, :outer_window => 1, renderer: WillPaginate::ActionView::BootstrapLinkRenderer
    else
      will_paginate collection, renderer: WillPaginate::ActionView::BootstrapLinkRenderer
    end
  end

  def has_action?(action)
    !@config[:index_actions].map(&:to_s).index(action.to_s).nil?
  end

  def is_action?(action_name)
    params[:action] === action_name
  end

  def path_to_new(controller, params = {})
    controller_name = controller.gsub('/', '_')
    send("new_#{(controller_name).singularize}_path", params)
  end
end
