extends Item

var is_get_dumpling_god = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        var scene: MyScene = get_scene()
        if scene.scene_objects.has("Performer") and !is_get_dumpling_god and is_stage_pre_show_right_place():  
            is_get_dumpling_god = true
            scene.scene_objects["Performer"].attr["have_new_screen"] = "Dumpling2"
            print("Hello get DumplingGod")
            add_button("DumplingGod","res://Assets/Scenes/dumpling gold.png","饺子神的房间")
            queue_free()
            
func is_stage_pre_show_right_place() -> bool:
    if self.get_anchor_name() == "DumplingPos":
        return true
    else:
        return false
