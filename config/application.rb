$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

def autoload_dir(dir)
  dir.each do |file|
    without_ext = File.basename(file, '.rb').to_s
    const = without_ext.split("_").map {|word| word.capitalize}.join
    autoload const, file
  end
end

Dir[File.expand_path('../initializers/*.rb', __FILE__)].each { |f| require f}

autoload_dir(Dir[File.expand_path('../../app/**/*.rb', __FILE__)])
