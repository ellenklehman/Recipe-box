require 'bundler/setup'
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(development_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Cook.all.each { |cook| cook.destroy }
    # Recipe_box.all.each { |recipe_box| recipe_box.destroy }
    # Recipe.all.each { |recipe| recipe.destroy }
  end
end
