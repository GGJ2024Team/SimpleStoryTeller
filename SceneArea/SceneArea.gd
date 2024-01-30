extends Area2D
class_name SceneArea

var scene_area_idx:int
var scene
#区域长宽的一半
export(int) var scene_area_x = 300
export(int) var scene_area_y = 165

onready var bg = $ColorRect
onready var label = $Label

func _ready():
    scene = get_node("Scene")
    
    
# ====== helper ======
func get_scene_container():
    return get_parent()
    
    
func has_button(name) -> bool:
    return get_scene_container().has_button(name)
    
    
func update_scene_area(add=[], remove=[]):
    var scene = get_node("Scene")
    if not holding_empty_scene():
        scene.update_scene(add, remove)
    
    
func holding_empty_scene() -> bool:
    return get_node("Scene").is_EmptyScene()
    
    
func check_game_finish() -> bool:
    return get_node("Scene").check_game_finish()


func get_scene_name() -> String:
    return get_node("Scene").scene_name
    
    
func change_scene(new_scene):
    scene = new_scene
    
    
func has_obj(obj_name):
    if holding_empty_scene():
        return false
    return get_node("Scene").has_obj(obj_name) 
    
    
func get_obj_attr(obj_name):
    if holding_empty_scene():
        return false
    return get_node("Scene").get_obj_attr(obj_name)
    
    
func set_interact_mode(mode:bool):
    get_node("Scene").set_interact_mode(mode)


func update_scene_using_prev_scene(prev_scene):
    scene.update_scene_using_prev_scene(prev_scene)
    
    
# ====== debug helper ======
func print_objs():
    get_node("Scene").print_objs()


func _on_ZoomButton_mouse_entered() -> void:
    bg.visible = true
    label.visible = true


func _on_ZoomButton_mouse_exited() -> void:
    label.visible = false
    bg.visible = false
