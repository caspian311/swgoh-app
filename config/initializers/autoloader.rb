paths = %w(
  config/initializers/*.rb
  lib/**/*.rb
).map(&:freeze).freeze

paths.each do |path|
 Dir[File.join(MyApp.root, path)].each do |file|
   next if file.include?('initializers/autoloader')
   require file
 end
end

