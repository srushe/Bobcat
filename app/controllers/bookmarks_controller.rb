class BookmarksController < ApplicationController
  before_filter :authenticate
  before_filter do |controller|
    @tags = @current_user.bookmarks.tag_counts_on(:tags, :order => "name")
  end
  
  # GET /bookmarks
  # GET /bookmarks.xml
  def index
    @bookmarks = @current_user.bookmarks.paginate(:page => params[:page], :per_page => Bookmark.per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.xml
  def show
    @bookmark = @current_user.bookmarks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.xml
  def new
    @bookmark = @current_user.bookmarks.build(params[:bookmark])

    respond_to do |format|
      format.html { render :layout => 'popup' } # new.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = @current_user.bookmarks.find(params[:id])
  end

  # POST /bookmarks
  # POST /bookmarks.xml
  def create
    @bookmark = @current_user.bookmarks.build(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        format.html { render :template => 'bookmarks/added', :layout => "popup", :notice => 'Bookmark was successfully created.' }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new", :layout => "popup" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.xml
  def update
    @bookmark = @current_user.bookmarks.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to(bookmarks_url, :notice => 'Bookmark was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.xml
  def destroy
    @bookmark = @current_user.bookmarks.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end

  # GET /bookmarks/search
  # GET /bookmarks/search.xml
  def search
    @bookmarks = @current_user.bookmarks.where("url like :input OR title like :input OR description like :input", { :input => "%#{params[:q]}%" }).order('created_at').paginate(:page => params[:page], :per_page => Bookmark.per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end

end
