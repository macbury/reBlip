class StoriesController < ApplicationController
  # GET /stories
  # GET /stories.xml
  def index
    options = {
      :order => 'created_at DESC', 
      :per_page => 10, 
      :page => params[:page]
    }
    
    if params[:query] && !params[:query].empty?
      options[:conditions] = ['( blips.body LIKE ? OR stories.body LIKE ? )', "%#{params[:query]}%", "%#{params[:query]}%"]
      options[:joins] = :blips
      options[:select] = 'distinct stories.*'
    end
    
    @stories = Story.paginate options

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find_by_blip_id(params[:id].to_i(32))
    #@story.blips.all(:order => 'created_at DESC')
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

end
