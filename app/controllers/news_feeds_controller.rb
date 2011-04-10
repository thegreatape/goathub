class NewsFeedsController < ApplicationController
  # skip the 'are you logged in' filter in favor of
  # one that checks that the news feed belongs to you
  skip_before_filter :authorize
  before_filter :must_own_feed

  # GET /news_feeds/1
  # GET /news_feeds/1.xml
  def show
    @news_feed = NewsFeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news_feed }
    end
  end

  # GET /news_feeds/1/edit
  def edit
    @news_feed = NewsFeed.find(params[:id])
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

  private
    def must_own_feed
      news_feed = NewsFeed.find(params[:id])
      # if logged in and trying view an unauthorized feed, redirect to 
      # user's own feed
      if session[:user_id] && news_feed.user_id != session[:user_id]
        redirect_to news_feed_path(User.find_by_id(session[:user_id]).news_feed) 
      elsif !session[:user_id]
        redirect_to login_url
      end
    end

end
