class BlipApi
   include HTTParty 
   base_uri "api.blip.pl" 
   #basic_auth "login", "pass" 
   format :json 
   headers "Accept" => "application/json", "User-Agent" => "ReBlip", "X-Blip-api" => "0.02"
   
   def self.start
     Thread.new do

       last_id = nil
       while true do
         begin
           last_id = BlipApi.fetch(last_id)
         rescue Exception => e
           last_id = nil
         end
         sleep 5
       end

     end
   end
   
   def self.fetch(blip_id=nil)
     begin
       out = get(blip_id.nil? ? "/statuses/all?limit=50&include=user,user[avatar],pictures,recording,movies" : "/statuses/#{blip_id}/all_since?limit=50&include=user,user[avatar],recording,pictures,movies")
     rescue Exception => e
       out = []
     end
     return if out.nil? || out.empty?

      ids = []
    out.each do |status|
      ids << status['id'].to_i

      story_line = BlipApi.create_story_line(status).reverse
      
      raw_story = story_line[0]
      story_line.delete_at(0)
      
      next if story_line.size > 1
      
      story = Story.find_or_initialize_by_blip_id(raw_story['id'])

      if story.new_record?
        story.author = raw_story['user']['login']
        story.avatar_path = raw_story['user']['avatar']['url_50']
        story.body = raw_story['body']
        story.add_asset(raw_story)
        story.created_at = raw_story['created_at']
        story.save
      end
      
      story_line.each do |raw_blip|
        blip = story.blips.find_or_initialize_by_blip_id(raw_blip['id'])
        if blip.new_record?
          blip.author = raw_blip['user']['login']
          blip.avatar_path = raw_blip['user']['avatar']['url_50']
          blip.body = raw_blip['body']
          blip.add_asset(raw_blip)
          blip.created_at = raw_blip['created_at']
          blip.save
        end
      end
      
    end
    
    return ids.max
   end 
   
   def self.create_story_line(status, array=nil)
     array ||= []
     array << status
     
     if status['body'] =~ /http:\/\/blip\.pl\/s\/([0-9]+)|http:\/\/www\.blip\.pl\/s\/([0-9]+)/i
       begin
         id = $1 || $2
         data = get("/statuses/#{id}?include=user,user[avatar],recording,pictures,movies")
         return BlipApi.create_story_line(data, array)
       rescue Exception => e
         return array
       end
     else
       return array
     end
   end
   
end

