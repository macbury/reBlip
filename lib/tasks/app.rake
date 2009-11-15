task :clear => :environment do
  Story.all.each(&:destroy)
end

task :bot => :environment do
  BlipApi.start.join
end