extends Item

func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        match scene_name:
            "Windowstill":
                print("hello Windowstill")
                var scene_objs = get_scene().scene_objects
                if scene_objs.has("FlowerPot") and scene_objs["FlowerPot"].attr["planted"]:
                    scene_objs["FlowerPot"].grow()
                get_scene().update_scene()

