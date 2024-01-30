extends Item

func _init_attr():
    pass
    
func _input(event: InputEvent) -> void:
    if overlapping_obj != null and event.is_action_released("ui_interact") and !is_interact_mode():
        if overlapping_obj.obj_name == "Dumpling":
            pop_bubble("dumpling")
            if get_scene().has_obj("Father"):
                get_scene().get_obj("Father").set_mood("happy")
            if get_scene().has_obj("Mother"):
                get_scene().get_obj("Mother").set_mood("happy")
