class StoriesController < ApplicationController
  # GET /stories
  # GET /stories.xml
  def index
    if params[:filter].nil?
      @sort_tag = 'newest'
    else
      @sort_tag = params[:filter]
    end
    
    options = {
      :order => 'created_at DESC', 
      :per_page => 10, 
      :page => params[:page]
    }
    
    if params[:query] && !params[:query].empty?
      options[:conditions] = ['( blips.body LIKE ? OR stories.body LIKE ? )', "%#{params[:query]}%", "%#{params[:query]}%"]
      options[:joins] = :blips
      options[:select] = 'distinct stories.*'
    elsif !params[:filter].nil? && params[:filter] != 'newest'
      f = params[:filter]
      min_blips = 10
      
      if f == 'day'
        from = Date.current.at_beginning_of_day
        to = Date.current.end_of_day
      elsif f == 'week'
        from = Date.current.at_beginning_of_week.to_datetime
        to = Date.current.end_of_week.to_datetime
      else
        from = Date.current.at_beginning_of_month.to_datetime
        to = Date.current.end_of_month.to_datetime
      end
      
      options[:conditions] = ["blips_count >= ? AND (stories.created_at >= ? AND stories.created_at <= ?)", min_blips, from, to]
      options[:order] = 'blips_count DESC'
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
