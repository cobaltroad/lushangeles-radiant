module CopyMove
  module Controller
    def self.included(base)
      base.class_eval do
        before_filter :load_page, :only => [:copy_page, :copy_children, :copy_tree, :move_page]
      end
    end

    def copy_page
      if request.request_method() == :get
        respond_to do |format|
          format.any {render :copy_page, :content_type => "text/html", :layout => false }
        end
      elsif request.request_method() == :post
        load_parent
        @new_page = @page.copy_to(@parent, params[:status_id])
        flash[:notice] = I18n.t('copied', :scope => :copy_move, :page => @page.title, :parent => @parent.title)
        redirect_to admin_pages_url
      end
    end

    def copy_children
      if request.request_method() == :get
        respond_to do |format|
          format.any {render :copy_children, :content_type => "text/html", :layout => false }
        end
      elsif request.request_method() == :post
        load_parent
        @new_page = @page.copy_with_children_to(@parent, params[:status_id])
        flash[:notice] = I18n.t('immediate_children_copied', :scope => :copy_move, :page => @page.title, :parent => @parent.title)
        redirect_to admin_pages_url
      end
    end

    def copy_tree
      if request.request_method() == :get
        respond_to do |format|
          format.any {render :copy_tree, :content_type => "text/html", :layout => false }
        end
      elsif request.request_method() == :post
        load_parent
        @new_page = @page.copy_tree_to(@parent, params[:status_id])
        flash[:notice] = I18n.t('descendants_copied', :scope => :copy_move, :page => @page.title, :parent => @parent.title)
        redirect_to admin_pages_url
      end
    end

    def move_page
      if request.request_method() == :get
        respond_to do |format|
          format.any {render :move_page, :content_type => "text/html", :layout => false }
        end
      elsif request.request_method() == :post
        load_parent
        @page.move_under(@parent, params[:status_id])
        if @page.children.any?
          flash[:notice] = I18n.t('descendants_moved', :scope => :copy_move, :page => @page.title, :parent => @parent.title)
        else
          flash[:notice] = I18n.t('moved', :scope => :copy_move, :page => @page.title, :parent => @parent.title)          
        end
        redirect_to admin_pages_url
      end
      rescue CopyMove::CircularHierarchy => e
        flash[:error] = e.message
        redirect_to admin_pages_url
    end
    
    private
    def load_parent
      @parent = Page.find(params[:parent_id])
    end
    
    def load_page
      self.model = @page = Page.find(params[:id])
    end
  end
end