class StoriesController < ApplicationController
  # GET /stories
  # GET /stories.xml
  def index
    @stories = Story.paginate :conditions => { :blips_count.gte => 2 }, :order => 'created_at DESC', :per_page => 10, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find_by_blip_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

end
