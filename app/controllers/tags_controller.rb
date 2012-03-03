class TagsController < ApplicationController
  before_filter :authenticate
  before_filter do |controller|
    bookmarks = @current_user.bookmarks
    if !bookmarks.empty?
      @tags = @current_user.bookmarks.tag_counts_on(:tags, :order => "name")
    else
      @tags = []
    end
  end

  # GET /tags
  # GET /tags.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    if @tag
      @bookmarks = @current_user.bookmarks.tagged_with(@tag.name).paginate(:page => params[:page], :per_page => Bookmark.per_page)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

end
