extends Item


func _input(event: InputEvent) -> void:
    if mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        var scene: MyScene = get_scene()
        if(scene.has_obj("Husband")):
            scene.scene_objects["Husband"].attr["bite_self"] = true
            print("bite_self")

        var anchor = get_parent()
        get_scene().update_scene([],[self])     
        anchor.disable()
        queue_free()
