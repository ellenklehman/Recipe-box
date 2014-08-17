
require 'pry'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
	system('clear')
	puts "Welcome to Recipe Box!  An app where you can store and track recipes at a restaurant."
	sleep(2)
	menu
end

def menu
	choice = nil
	until choice == 'x'
		puts "Type 'c' to add a cook."
		puts "Type 'b' to add a recipe box."
		puts "Type 'r' to add a recipe."
		puts "Type 'lc' to list all of the cooks and alter or search their recipes AND/OR edit them."
		puts "Type 'lb' to list all of the recipe boxes."
		puts "Type 'lr' to list all of the recipes."
		puts "Type 's' to search for a recipe, cook, or recipe box."
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
		when 's'
			search
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
	  Cook.all.each { |cook| puts "#{cook.id}: #{cook.name}"}
	end
	puts "Type the number of the cook for whom you would like to create a box."
	cook_id = gets.chomp.to_i
	puts "What is the name of the box you would like to add?"
	box_name = gets.chomp
	Box.create({:name => box_name, :cook_id => cook_id})
end

def add_recipe
	if Box.all.empty?
	  puts "Please add a box before trying to add a recipe."
	  sleep(2)
	  menu
	else
	  Cook.all.each { |cook| puts "#{cook.id}: #{cook.name}"}
	end
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
	system('clear')
	Cook.all.each { |cook| puts "#{cook.id}: #{cook.name}"}
	puts "Type the number of the cook you would like to access."
	cook_id = gets.chomp
	cook = Cook.find(cook_id)
	puts "Type 'recipe' to see a specific recipe for this cook."
	puts "Type 'box' to see a specific recipe box for this cook."
	puts "Type 'sb' to see all of the boxes for this cook."
	puts "Type 'sr' to see all of the recipes for this cook."
	puts "Type 'c' for a number of all of the recipes this cook has."
	choice = gets.chomp.downcase
	case choice
	when 'recipe'
		puts "What is the name of the recipe you would like to view?"
		recipe_name = gets.chomp.downcase
		selected_recipe = cook.find_recipe(recipe_name)
		puts "#{selected_recipe.name}:    #{selected_recipe.instructions}"
		sleep(4)
	when 'box'
		puts "What is the name of the box you would like to view?"
		box_name = gets.chomp.downcase
		selected_box = cook.find_box(box_name)
		selected_box.recipes.each { |recipe| puts recipe.name }
		sleep(2)
	when 'sb'
		cook.boxes.each { |box| puts box.name }
		sleep(2)
	when 'sr'
		cook.recipes.each { |recipe| puts recipe.name }
		sleep(2)
	when 'c'
		count = cook.count_recipes
		puts "Recipe count: #{count}"
		sleep(2)
	else
		puts "Please enter a valid option"
		list_cooks
	end
end

def list_boxes_by_cook(cook_id)
	cook = Cook.find(cook_id)
	cook.boxes.each {|box| puts "#{box.id}: #{box.name}" }
end

def list_boxes
	Box.all.each { |box| puts "#{box.id}: #{box.name}"}
end

def list_recipes_by_box(box_id)
	box = Box.find(box_id)
	box.recipes.each {|recipe| puts "#{recipe.id}: #{recipe.name}"}
end

def list_recipes
	Recipe.all.each { |recipe| puts "#{recipe.id}: #{recipe.name}"}
end

def list_recipes_by_cook(cook_id)
	cook = Cook.find(cook_id)
	cook.recipes.each { |recipe| puts "#{recipe.id}: #{recipe.name}"}
end

def search
	system('clear')

	puts "Here are a few of the most recent recipe additions:"
	Recipe.recent.each { |recipe| puts recipe.name}
	puts "Type 'c' to search for a cook."
	puts "Type 'b' to search for a recipe box."
	puts "Type 'r' to search for a recipe."
	puts "Type 'm' to return to the main menu."
	choice = gets.chomp.downcase
	case choice
	when 'c'
		search_cooks
	when 'b'
		search_boxes
	when 'r'
		search_recipes
	when 'm'
		menu
	else
		puts "That wasn't a valid option."
		search
	end
end

def search_cooks
	system('clear')
	puts "What cook are you looking for?"
	cook_query = gets.chomp.downcase
	cooks = Cook.basic_search(cook_query)
	cooks.each { |cook| puts cook.name}
end

def search_boxes
	system('clear')
	puts "What recipe box are you looking for?"
	box_query = gets.chomp.downcase
	boxes = Box.basic_search(box_query)
	boxes.each { |box| puts box.name}
end

def search_recipes
	system('clear')
	puts "What recipe are you looking for?"
	recipe_query = gets.chomp.downcase
	recipes = Recipe.basic_search(recipe_query)
	recipes.each { |recipe| puts recipe.name + ":   " + recipe.instructions}
end

def clear_database
	system('clear')
	Cook.destroy_all
	Box.destroy_all
	Recipe.destroy_all
	puts "Database has been cleared."
end
welcome
