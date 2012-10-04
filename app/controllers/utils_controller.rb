class UtilsController < BaseController

  include TranslationHelper

  def formatizer
    text = params["text"] || ""
    render :json => { :text => t_(nil, text) }
  end

end