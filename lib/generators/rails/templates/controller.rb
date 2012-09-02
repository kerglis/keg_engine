<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController

  inherit_resources

  # def destroy
  #   destroy_object
  # end

  # def swap
  #   swap_object
  # end

  # def create
  #   create!{ collection_url }
  # end

  # def update
  #   update!{ collection_url }
  # end

  private

  def collection
    load_filters
    @search = <%= class_name %>.metasearch(@filters)
    @collection = @search.paginate( :per_page => @rpp, :page => params[:page])
  end

end
<% end -%>