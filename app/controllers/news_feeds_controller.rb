class NewsFeedsController < ApplicationController
  # GET /news_feeds
  # GET /news_feeds.xml
  def index
    @news_feeds = NewsFeed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news_feeds }
    end
  end

  # GET /news_feeds/1
  # GET /news_feeds/1.xml
  def show
    @news_feed = NewsFeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news_feed }
    end
  end

  # GET /news_feeds/new
  # GET /news_feeds/new.xml
  def new
    @news_feed = NewsFeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news_feed }
    end
  end

  # GET /news_feeds/1/edit
  def edit
    @news_feed = NewsFeed.find(params[:id])
  end

  # POST /news_feeds
  # POST /news_feeds.xml
  def create
    @news_feed = NewsFeed.new(params[:news_feed])

    respond_to do |format|
      if @news_feed.save
        format.html { redirect_to(@news_feed, :notice => 'News feed was successfully created.') }
        format.xml  { render :xml => @news_feed, :status => :created, :location => @news_feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news_feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news_feeds/1
  # PUT /news_feeds/1.xml
  def update
    @news_feed = NewsFeed.find(params[:id])

    respond_to do |format|
      if @news_feed.update_attributes(params[:news_feed])
        format.html { redirect_to(@news_feed, :notice => 'News feed was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news_feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news_feeds/1
  # DELETE /news_feeds/1.xml
  def destroy
    @news_feed = NewsFeed.find(params[:id])
    @news_feed.destroy

    respond_to do |format|
      format.html { redirect_to(news_feeds_url) }
      format.xml  { head :ok }
    end
  end
end
