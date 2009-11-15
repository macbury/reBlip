# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sort_tab(name, tab)
    options = { :page => params[:page] || 1 , :filter => tab }
    link_to name, options, :class => tab == @sort_tag ? 'selected' : 'normal'
  end
end
