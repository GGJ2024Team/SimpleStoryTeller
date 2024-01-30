extends Item

func _ready() -> void:
    pass
    
func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        match scene_name:
            "Bedroom":
                get_anchors().get_node("FlowerPos").enable()
                var scene_objs = get_scene().scene_objects
                if scene_objs.has("SpringOnion"):
                    print(scene_objs["SpringOnion"].anchor_name )
                if scene_objs.has("SpringOnion") and scene_objs["SpringOnion"].anchor_name == "FlowerPos":
                    if scene_objs.has("Miku"):
                        scene_objs["Miku"].set_mood("happy")
                get_scene().update_scene()
