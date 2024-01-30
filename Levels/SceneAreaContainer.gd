extends Node2D

var build_mode:bool = false
var zoom_in:bool = false
var current_build_type:String = ""
var current_scene_area_idx:int = 0
var scene_area_array = [null] # dummyHead
var InfoButton = preload("res://UI/InfoButton.tscn")
var FloatText = preload("res://Effects/FloatText.tscn")
var buttons := DS.Set.new()

onready var ui = $UI
onready var button_container = $UI/HUD/CenterCotainer/HBoxContainer
onready var camera = $Camera2D
onready var mouse = $Mouse

signal game_finished_sig
signal game_restart

# ====== DlinkList ======   
func is_tail(area):
    return area.scene_area_idx == scene_area_array.size() - 1
    
    
func prev_area(area):
    if area.scene_area_idx - 1 >= 0:
        return scene_area_array[area.scene_area_idx-1]
    
    
func next_area(area):
    if area.scene_area_idx + 1 < scene_area_array.size():
        return scene_area_array[area.scene_area_idx+1]
    return null


# ====== 引擎自动调用 ======     
func _ready() -> void:
    for build_button in get_tree().get_nodes_in_group("build_buttons"):
        build_button.connect("pressed", self, "init_build", [build_button.get_name()])
    for build_button in get_tree().get_nodes_in_group("build_button"):
        build_button.connect("pressed", self, "init_build", [build_button.get_name()])
    for scene_area in get_tree().get_nodes_in_group("scene_area"):
        scene_area.scene_area_idx = int(scene_area.get_name().split("_")[-1])
        scene_area_array.append(scene_area)
        scene_area.set_interact_mode(false)
        scene_area.get_node("ZoomButton").connect("pressed", self, "zoom", [scene_area])
        
        
func _process(delta):
    mouse.position = get_global_mouse_position()
    if build_mode:
        update_preview()


func _input(event: InputEvent) -> void:
    if event.is_action_released("ui_esc"):
        get_tree().quit() 
        
        
func _unhandled_input(event):
    if event.is_action_pressed("ui_cancel") and build_mode:
        cancel_build_mode()
    if event.is_action_released("ui_accept") and build_mode and GameData.is_scene(current_build_type) and current_scene_area_idx != 0:
        verify_and_build_scene()
        cancel_build_mode()
        
        
# ====== helper ======
func zoom(scene_area):
    if zoom_in:
        camera.zoom = Vector2(1, 1)    
        camera.position = Vector2(1920/2, 1080/2)
        ui.visible = true
        scene_area.set_interact_mode(false)
    else:
        camera.zoom = Vector2(0.32, 0.32)   
        camera.position.x = scene_area.position.x+300
        camera.position.y = scene_area.position.y+165
        ui.visible = false
        scene_area.set_interact_mode(true)
    zoom_in = not zoom_in
   

func init_build(build_type:String):
    if build_mode:
        cancel_build_mode()
    current_build_type = build_type
    build_mode = true
    var preview_build = load(GameData.build_path_map[build_type]).instance()
    preview_build.set_name("PreviewBuild")
    preview_build.modulate.a = 0.8
    
    var control = Control.new()
    control.add_child(preview_build, true)
    control.rect_position = get_local_mouse_position()
    control.set_name('ControlPreviewBuild')
    ui.add_child(control, true)
    ui.move_child(control, 0) # 移动到最上层
    
    
func init_build_with_scene_obj(obj):
    if build_mode:
        cancel_build_mode()
        
    current_build_type = obj.obj_name
    build_mode = true
    obj.set_name("PreviewBuild")
    obj.modulate.a = 0.8
    
    var control = Control.new()
    control.add_child(obj, true)
    control.rect_position = get_local_mouse_position()
    control.set_name('ControlPreviewBuild')
    ui.add_child(control, true)
    ui.move_child(control, 0) # 移动到最上层
    
    
func verify_and_build_scene():
    if GameData.is_scene(current_build_type) and current_scene_area_idx != 0:
        var new_scene = load("res://Scenes/" + current_build_type + ".tscn").instance()
        var scene_area = scene_area_array[current_scene_area_idx]
        new_scene.position = scene_area.get_node("Scene").position
        scene_area.get_node("Scene").free()
        new_scene.set_name("Scene")
        new_scene.scene_area_idx = current_scene_area_idx
        new_scene.connect("scene_updated", self, "_on_scene_updated", [new_scene])

        for anchor in new_scene.get_node("Anchors").get_children():
            var anchor_button = anchor.get_node("AnchorButton")
            anchor_button.connect("pressed", self, "verify_and_build_obj", [anchor])
        scene_area.add_child(new_scene, true)
        scene_area.move_child(new_scene, 0)
        scene_area.change_scene(new_scene)
        
        # init pre build scene_objects
        for anchor in new_scene.get_node("Anchors").get_children():
            if anchor.get_child_count() > 1:
                init_new_scene_obj(anchor, anchor.get_child(1))
        
        
func verify_and_build_obj(anchor):
    if build_mode and not GameData.is_scene(current_build_type):
        var scene = anchor.get_parent().get_parent()
        if scene.has_obj(current_build_type):
            return 
        var new_scene_obj = load(GameData.build_path_map[current_build_type]).instance()
        init_new_scene_obj(anchor, new_scene_obj)
 

func init_new_scene_obj(anchor, new_scene_obj):
    var scene = anchor.get_scene()
    var idx = anchor.get_scene_area_idx()
    new_scene_obj.scene_area_idx = idx
    new_scene_obj.scene_name = scene_area_array[idx].get_scene_name()
    if idx - 1 > 0 and scene_area_array[idx-1].has_obj(current_build_type):
        new_scene_obj.attr = scene_area_array[idx-1].get_obj_attr(current_build_type).duplicate(true)
    new_scene_obj.connect("obj_deleted_sig", self, "_on_scene_obj_deleted", [new_scene_obj])
    new_scene_obj.connect("add_button_sig", self, "add_button")
    if !new_scene_obj.get_parent():
        anchor.add_child(new_scene_obj)   
    anchor.disable()
    scene.add_obj(new_scene_obj)
    scene.update_scene()
    cancel_build_mode()
    
        
func cancel_build_mode():
    if build_mode:
        build_mode = false 
        current_build_type = ""
        get_node("UI/ControlPreviewBuild").free()
    
    
func update_preview():
    var mouse_position = get_global_mouse_position()
    ui.get_node("ControlPreviewBuild").rect_position = mouse_position
    
    
func has_button(name):
    return buttons.has(name)
    
    
func add_button(name, button_icon_path=null, button_info=null):
    if !has_button(name):
        var new_button = InfoButton.instance()
        new_button.set_name(name)
        if button_info == null:
            new_button.set_label_text(name)
        else:
            new_button.set_label_text(button_info)
        new_button.connect("pressed", self, "init_build", [name])
        var icon = TextureRect.new()
        icon.rect_size = Vector2(100, 100)
        icon.expand = true
        icon.rect_position = Vector2(2, 2)
        if button_icon_path != null:
            icon.texture = load(button_icon_path)
        new_button.add_child(icon)
        button_container.add_child(new_button)
        buttons.add(name)
        var float_text = FloatText.instance()
        float_text.set_text("获得新场景/道具")
        float_text.set_text_size(10)
        add_child(float_text)
        
            
     
func show_fire_work():
    var firework = load("res://Effects/Fireworks.tscn").instance()
    firework.position.x = 900
    firework.position.y = 400
    add_child(firework)
    firework.start()
           
        
# ====== signal ======
func _on_scene_obj_deleted(obj):
    scene_area_array[obj.scene_area_idx].update_scene_area([], [obj])
    init_build_with_scene_obj(obj)
   

func _on_scene_updated(scene):
    _scene_obj_updated(scene)
    
    
func _scene_obj_updated(scene):
    var scene_area = scene_area_array[scene.scene_area_idx]
    var idx = scene.scene_area_idx
    if scene_area.check_game_finish():
        show_fire_work()
        var float_text = FloatText.instance()
        float_text.set_text("Winner Winner")
        add_child(float_text)
        move_child(float_text, 3)
        emit_signal("game_finished_sig")
        return
    if !(is_tail(scene_area) or next_area(scene_area).holding_empty_scene()):
        yield(get_tree().create_timer(2.0), "timeout") # wait a few sec
        next_area(scene_area).update_scene_using_prev_scene(scene_area)       
   
 
func _on_Mouse_area_entered(area: Area2D) -> void:
    current_scene_area_idx =  area.scene_area_idx


func _on_Mouse_area_exited(area: Area2D) -> void:
    if current_scene_area_idx == area.scene_area_idx:
        current_scene_area_idx =  0


func _on_Restart_pressed() -> void:
    var game = get_parent()
    game.remove_child(self)
    var level = load("res://Levels/Level"+str(GameData.current_level)+".tscn").instance()
    game.add_child(level)
    queue_free()


func _on_Return_pressed() -> void:
    get_tree().reload_current_scene() 
