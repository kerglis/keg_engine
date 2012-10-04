class UtilsController < ApplicationController

  include TranslationHelper

  def formatizer
    text = params["text"] || ""
    render :json => { :text => t_(nil, text) }
  end

end