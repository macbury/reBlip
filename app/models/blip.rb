class Blip < ActiveRecord::Base
  belongs_to :story, :counter_cache => true
  xss_terminate
  
  def add_asset(data)
    Blip.set_asset_for(self, data)
  end
  
  def self.set_asset_for(blip, data)
    if data['pictures']
      blip.status_type = "Picture"
      blip.asset_path = data['pictures'][0]['url']
    elsif data['movies'] || data['body'] =~ /(http:\/\/www\.youtube\.com\/watch\?v=[a-zA-Z0-9]+)/i
      blip.status_type = "Movie"
      if $1.nil?
        blip.asset_path = data['movies'][0]['url']
      else
        blip.asset_path = $1
      end
    elsif data['recording']
      blip.status_type = "Recording"
      blip.asset_path = data['recording'][0]['url']
    else
      blip.status_type = "Status"
    end
  end
  
end
