ActionController::Routing::Routes.draw do |map|
  map.with_options(:controller => "admin/pages") do |page|
    page.copy_page     '/admin/pages/:id/copy_page',     :action => 'copy_page'
    page.copy_children '/admin/pages/:id/copy_children', :action => 'copy_children'
    page.copy_tree     '/admin/pages/:id/copy_tree',     :action => 'copy_tree'
    page.move_page     '/admin/pages/:id/move_page',     :action => 'move_page'
  end
end