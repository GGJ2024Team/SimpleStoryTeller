extends Node

var game_scene
func _ready():
    load_main_menu()
    
func load_main_menu():
    get_node("Menu/MarginContainer/VBoxContainer/NewGame/").connect("pressed", self, "on_new_game_pressed")
    get_node("Menu/MarginContainer/VBoxContainer/Quit").connect("pressed", self, "on_quit_pressed")
    
func on_new_game_pressed():
    get_node("Menu").queue_free()
    game_scene = load("res://UI/LevelSelection.tscn").instance()
    add_child(game_scene)
    
func on_quit_pressed():
    get_tree().quit()

func unload_game(result):
    game_scene.queue_free()
    var main_menu = load("res://UI/Menu.tscn").instance()
    add_child(main_menu)
    load_main_menu()
