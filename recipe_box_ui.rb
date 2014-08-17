
require 'pry'
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
		when 'x'
			exit
		else
			puts "That wasn't a valid option"
		end
	end
end

def add_cook
	puts "What is the name of the cook you would like to add?"
	cook_name = gets.chomp
	Cook.create({:name => cook_name})
end

def add_box
	if Cook.all.empty?
	  puts "Please add a cook before trying to add a box."
	  menu
	else
	  list_cooks
	end
	"\n"
	puts "Type the number of the cook for whom you would like to create a box."
	cook_id = gets.chomp.to_i
	puts "What is the name of the box you would like to add?"
	box_name = gets.chomp
	Box.create({:name => box_name, :cook_id => cook_id})
end

def add_recipe
	if Box.all.empty?
	  puts "Please add a box before trying to add a recipe."
	  menu
	else
	  list_cooks
	end
	"\n"
	puts "Type the number of the cook for whom you would like to add a recipe."
	cook_id = gets.chomp.to_i
	list_boxes_by_cook(cook_id)
	puts "Type the number of the box to which you would like to add a recipe."
	box_id = gets.chomp.to_i
	box = Box.find(box_id)
	puts "What is the name of the recipe you would like to add?"
	recipe_name = gets.chomp
	puts "What are the instructions for this recipe?"
	instructions = gets.chomp
	box.recipes.create({:name => recipe_name, :instructions => instructions, :cook_id => cook_id})
end

def list_cooks
	Cook.all.each { |cook| puts "#{cook.id}: #{cook.name}"}
end

def list_boxes_by_cook(cook_id)
	cook = Cook.find(cook_id)
	cook.boxes.each {|box| puts "#{box.id}: #{box.name}" }
end

def list_boxes
	Box.all.each { |box| puts "#{box.id}: #{box.name}"}
end

def list_recipes_by_box(box_id)
	box = Box.where(:id => box_id)
	box.recipes.each {|recipe| puts "#{recipe.id}: #{recipe.name}"}
end

def list_recipes
	Recipe.all.each { |recipe| puts "#{recipe.id}: #{recipe.name}"}
end

def list_recipes_by_cook(cook_id)
	cook = Cook.where(:id => cook_id)
	cook.recipes.each { |recipe| puts "#{recipe.id}: #{recipe.name}"}
end


def clear_database
	Cook.destroy_all
	Box.destroy_all
	Recipe.destroy_all
	puts "Database has been cleared."
end















welcome
