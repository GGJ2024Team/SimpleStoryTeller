extends Item


func _input(event: InputEvent) -> void:
    if mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        var scene: MyScene = get_scene()
        if(scene.has_obj("Husband")):
            if scene.scene_objects["Husband"].attr["bite_self"]:
                scene.scene_objects["Husband"].attr["bite_boss"] = true
                print("bossssss bited")
                get_scene().update_scene()
                
            elif scene.scene_objects["Husband"].attr["get_cactus"]:
                scene.scene_objects["Husband"].attr["fired"] = true
                print("fired")
                get_scene().update_scene()
                
