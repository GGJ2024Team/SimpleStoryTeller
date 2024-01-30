extends Node2D
class_name SceneObject

var Bubble := preload("res://Effects/Bubble.tscn")
var TextBubble := preload("res://Effects/TextBubble.tscn")
var scene_area_idx:int
var scene_name:String #属于哪个scene
var anchor_name:String 
export(String) var obj_name:String
var overlapping_obj # 与当前SceneObject位置重合的另一个SceneObject
var attr := {} # {属性名:属性值}
signal obj_deleted_sig
signal obj_updated_sig
signal add_button_sig(name, button_icon_path, button_info)


var placed:bool = false
var selected:bool = false
var mouse_in_range:bool = false

func _init() -> void:
    _init_attrs()


# ====== 子类重写 ======
func _init_attrs():
    pass
    
    
func _update_attr(scene_objects):
    pass 
    
    
func _input_event(event: InputEvent):
    pass
    
    
# ====== helper ======
func has_button(name):
    return get_scene().has_button(name)
    
    
func add_button(name, button_icon_path=null, button_info=null):
    emit_signal("add_button_sig", name, button_icon_path, button_info)
        
        
func get_scene():
    # obj->Anchor->Anchors->Scene
    return get_parent().get_parent().get_parent()
    
    
func get_anchors():
    return get_parent().get_parent()
    
    
func is_interact_mode():
    if !placed:
        return true
    return get_scene().is_interact_mode()


func is_mouse_in_range():
    return mouse_in_range
       
    
func has_attr(attr_name):
    return attr.has(attr_name)
    
    
func add_attr(attr_name, init_val):
    if has_attr(attr_name):
        printerr("add_attr：已经有这个属性了，不要重复添加")
        return 
    attr[attr_name] = init_val
    
    
func get_attr(attr_name):
    if !has_attr(attr_name):
        printerr("get_attr:  没这个属性")
        return
    return attr[attr_name]
     
    
func set_attr(attr_name, new_val):
    if !has_attr(attr_name):
        printerr("set_attr： 没有这个属性")
        return 
    attr[attr_name] = new_val


func get_attrs(duplicate = true):
    if duplicate:
        return attr.duplicate(true)
    return attr
    
    
func pop_bubble(bubble_picture_path):
    var bubble = Bubble.instance()
    bubble.emoji_path = bubble_picture_path
    bubble.bubble_last_sec = 2
    add_child(bubble)
   

func pop_text_bubble(text):
    var bubble = TextBubble.instance() 
    bubble.set_text(text)
    add_child(bubble)
    bubble.play()
    
    
func is_mouse_click(event: InputEvent):
    return placed and mouse_in_range and is_interact_mode() and event.is_action_released("ui_accept") 
    
func is_overlapping_with_obj():
    return placed and overlapping_obj != null and !is_interact_mode()
    
func is_interacting_with_obj(event: InputEvent):
    return is_overlapping_with_obj() and  event.is_action_released("ui_interact")


func get_anchor_name():
    if !placed:
        printerr("try to get the anchor_name of a not placed scene object")
        return "NoAnchorNotPlaced"
    return get_parent().get_name()
    
    
# ====== debug helper ======
func print_attr():
    print("====== " + "attr of : " + obj_name + " ====== ")
    for k in attr:
        print(k + " : " , attr[k])
    print("============")   
    
    
# ====== called by parent node ======
func update_attr(scene_objects):
    _update_attr(scene_objects)
    emit_signal("obj_updated_sig")
    
    
# ====== signal ======
func _input(event: InputEvent) -> void:
    if !is_interact_mode() and placed and mouse_in_range and event.is_action_released("ui_accept"):
        emit_signal("obj_deleted_sig")
        return
    _input_event(event)


func _on_SceneObject_mouse_entered() -> void:
    mouse_in_range = true
    
    
func _on_SceneObject_mouse_exited() -> void:
    mouse_in_range = false
       
    
func _on_SceneObject_area_entered(area: Area2D) -> void:
    overlapping_obj = area
    
    
func _on_SceneObject_area_exited(area: Area2D) -> void:
    if overlapping_obj == area:
        overlapping_obj = null
