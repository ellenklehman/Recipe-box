Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
	puts "Welcome to Recipe Box!  An app where you can store and track recipes at a restaurant."
	menu
end

def menu
	choice = nil
	until choice == 'x'
		puts "Type 'c' to add a cook."
		puts "Type 'b' to add a recipe box."
		puts "Type 'r' to add a recipe."
		puts "Type 'lc' to list all of the cooks and alter or search their recipes AND/OR edit them."
		puts "Type 'lb' to list all of the recipe boxes and see their owners or recipes AND/OR edit them."
		puts "Type 'lr' to list all of the recipes and see their boxes or cooks AND/OR edit them."
		puts "Type 'clear' to clear the entire database."
		puts "Type 'x' to exit the program."
		choice = gets.chomp.downcase
		case choice
		when 'c'
			add_cook
		when 'b'
			add_box
		when 'r'
			add_recipe
		when 'lc'
			list_cooks
		when 'lb'
			list_boxes
		when 'lr'
			list_recipes
		when 'clear'
			clear_database
		else
			puts "That wasn't a valid option"
		end
	end
end

welcome
