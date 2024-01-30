extends Item


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.



func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        var scene: MyScene = get_scene()
        if scene.scene_objects.has("Performer"):  
            scene.scene_objects["Performer"].attr["have_dumpling_wrappers"] = true
            queue_free()
