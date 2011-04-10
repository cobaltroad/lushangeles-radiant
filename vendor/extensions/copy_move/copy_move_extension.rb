require_dependency 'application_controller'

class CopyMoveExtension < Radiant::Extension
  version "#{File.read(File.expand_path(File.dirname(__FILE__)) + '/VERSION')}"
  description "Adds the ability to copy or move a page with or without its children"
  url "https://github.com/jomz/radiant-copy-move"

  def activate
    Admin::PagesController.class_eval do
      include CopyMove::Controller
      helper :copy_move
    end
    Page.class_eval { include CopyMove::Model }
    admin.page.index.add :sitemap_head, 'copy_move_extra_th', :before => 'actions_column_header'
    admin.page.index.add :node, 'copy_move_extra_td', :before => 'actions_column'
  end
end
