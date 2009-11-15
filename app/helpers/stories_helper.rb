module StoriesHelper
  
  def generuj_typ(blip)
    return  case blip.status_type
              when 'Picture' then 'Obrazek' 
              when 'Movie' then 'Film' 
              when 'Recording' then 'Nagranie' 
              else 'Status'
            end
  end
  
  def render_asset(blip)
    link = nil
    
    if blip.status_type == 'Picture'
      link = image_tag(thumb_image(blip.asset_path))
      href = blip.asset_path
    end
            
    if link
      return link_to(link, href, :class => 'asset')
    end
  end
  
  def thumb_image(path)
    path.gsub(/([0-9]+)\.(jpg|gif|jpeg|png)$/i, '\1_standard.\2')
  end
  
  def format_blip(blip)
    body = blip.body.gsub(/http:\/\/blip\.pl\/s\/([0-9]+)/i, '')
    body.gsub!(/#([a-zA-Z0-9]+)/i, link_to('#\1', 'http://blip.pl/tags/\1', :target => "_blank"))
    body.gsub!(/\^([a-zA-Z0-9]+)/i, link_to('^\1', 'http://\1.blip.pl/', :target => "_blank"))
    
    return auto_link(body.strip)
  end
  
end
