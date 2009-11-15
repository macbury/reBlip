class Story < ActiveRecord::Base
  has_many :blips, :dependent => :destroy
  xss_terminate
  
  def to_param
    self.blip_id.to_s
  end
  
  def add_asset(data)
    Blip.set_asset_for(self, data)
  end
  
end
