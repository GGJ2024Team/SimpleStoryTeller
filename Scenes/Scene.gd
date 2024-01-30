extends Node2D
class_name MyScene

var scene_area_idx:int setget , get_scene_area_idx
export(String) var scene_name:String
var states = {} #  场景的状态，例如下雨，下雪等
var scene_objects = {} # 场景中的SceneObject, {obj_name: 对象的引用}
var interact_mode:bool = false # 是否能介入场景
signal scene_updated
signal add_button_sig(name, button_icon_path, button_info)

# ====== helper ======
func get_scene_area():
    return get_parent()
    
    
func has_button(name) -> bool:
    return get_scene_area().has_button(name)
    
    
func add_button(name, button_icon_path=null, button_info=null):
    emit_signal("add_button_sig", name, button_icon_path, button_info)
    
    
func set_interact_mode(mode):
    interact_mode = mode
    
    
func get_scene_area_idx():
    return scene_area_idx
    
    
func is_interact_mode():
    return interact_mode
    
    
func is_EmptyScene() -> bool:
    return scene_name == "EmptyScene"
    
    
func check_game_finish() -> bool:
    var finish_conditions = GameData.get_game_finish_condition(GameData.current_level)
    for obj in finish_conditions:
        if not scene_objects.has(obj):
            return false
        for attr_name in finish_conditions[obj]:
            if scene_objects[obj].attr[attr_name] != finish_conditions[obj][attr_name]:
                return false
    return true
    
    
func has_obj(obj_name):
    return scene_objects.has(obj_name)
 

func get_obj(obj_name):
    return scene_objects[obj_name]
    
    
func get_obj_attr(obj_name):
    return scene_objects[obj_name].attr
      
    
func remove_obj(obj):
    if has_obj(obj.obj_name):
        obj.placed = false
        var anchor = obj.get_parent()
        anchor.remove_child(obj)
        anchor.enable()
        scene_objects.erase(obj.obj_name)
    else:
        printerr("try to remove non-exist obj from scene")
  

func add_obj(obj):
    # anchor.add_child 在 SceneContainer中处理
    obj.placed = true
    scene_objects[obj.get_name()] = obj
    
    
func update_scene(add:Array=[], remove:Array = []):
    for obj in add:
        add_obj(obj)
    for obj in remove:
        remove_obj(obj)  
    for scene_obj in scene_objects:
        scene_objects[scene_obj].update_attr(scene_objects) 
    emit_signal("scene_updated")


func update_scene_using_prev_scene(prev_scene):
    for obj_name in scene_objects:
        if prev_scene.has_obj(obj_name):
            scene_objects[obj_name].attr = prev_scene.get_obj_attr(obj_name).duplicate(true)
        else:
            scene_objects[obj_name]._init_attrs()
    update_scene([], [])


# ====== debug helper ======
func print_objs():
    print("====== objs in scene : " + scene_name + "======")
    for k in scene_objects:
        print(k)
    print("============")
