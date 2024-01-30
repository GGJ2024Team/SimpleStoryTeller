extends Node

var build_path_map = {} # {scene_name: scene_path(.tscn)}
var is_scene_map = {} # {scene_name : bool}
var current_level = 7

# LEVELS:
# {
#    level_number : {
#       scene_obj_name: {attr_1: val}, 
#      }
#}
var LEVELS = {
    0: {"Mother":{"mood":"happy"}},
    1: {"Miku":{"mood":"happy"}},
    2: {"Husband":{"mood":"success"}},
    3: {"Audience":{"mood":"happy"}},
    4: {"Mother":{"mood":"happy"}},
    5: {"Miku":{"mood":"happy"}},
    6: {"Father":{"mood":"happy"}},
    7: {"Husband":{"mood":"success"}}
   }
var mood_emojis = {} #{mood_name: emoji_path}

func _ready() -> void:
    dir_contents("res://SceneObjects", false) 
    dir_contents("res://Scenes", true) 
    dir_contents_emojis("res://Assets/Effects/Emojis/")

func get_game_finish_condition(level = 0):
    return LEVELS[level]
    
func dir_contents(path, is_scene:bool):
    var dir = Directory.new()
    if dir.open(path) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if file_name == "." or file_name == "..":
                pass
            elif dir.current_is_dir():
                dir_contents(path + "/"+ file_name, is_scene)
            else:
                build_path_map[file_name.split(".")[0]] = path + "/"+ file_name
                is_scene_map[file_name.split(".")[0]] = is_scene
            file_name = dir.get_next()
    else:
        printerr("尝试访问路径时出错。")

func dir_contents_emojis(path):
    var dir = Directory.new()
    if dir.open(path) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if file_name == "." or file_name == "..":
                pass
            else:
                mood_emojis[file_name.split(".")[0]] = path + file_name.substr(0, file_name.length()-7)
            file_name = dir.get_next()
    else:
        printerr("尝试访问路径时出错。")
        
func is_scene(file_name) -> bool:
    return is_scene_map[file_name]
