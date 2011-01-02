class RefineryFilebrowsersController < ApplicationController

  before_filter :find_all_refinery_filebrowsers
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @refinery_filebrowser in the line below:
    present(@page)
  end

  def show
    @refinery_filebrowser = RefineryFilebrowser.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @refinery_filebrowser in the line below:
    present(@page)
  end

protected

  def find_all_refinery_filebrowsers
    @refinery_filebrowsers = RefineryFilebrowser.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/refinery_filebrowsers")
  end

end
