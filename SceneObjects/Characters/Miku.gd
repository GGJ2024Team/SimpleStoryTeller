extends Character

func _init_attrs():
    add_attr("miku_hit_count", 0)
#    set_mood("normal")
    
func _update_attr(scene_objects):
    match scene_name:
        "Bedroom":
            print("hello bedroom")
            if scene_objects.has("SpringOnion") and \
            scene_objects["SpringOnion"].get_anchor_name() == "FlowerPos" and \
            scene_objects.has("Vase") and \
            scene_objects["Vase"].get_anchor_name() == "VasePos":
                set_mood("happy")
                print("miku happy")
            else:
                set_mood("normal")
                

func _input_event(event: InputEvent) -> void:
    if is_mouse_click(event):
        match GameData.current_level:
            5:
                set_mood("happy")
                pop_text_bubble("Hello MIKU")

                attr["miku_hit_count"] += 1
                add_button("Seed", null, "种子")
                get_scene().update_scene()
        
    if is_interacting_with_obj(event):
        pop_text_bubble("Hello MIKU")
        

#func _on_SceneObject_area_entered(area: Area2D) -> void:
#    print("in miku")
#    if Input.is_action_just_pressed("ui_interact"):
#        print("MikuMikuMiku")
#
#
#func _on_SceneObject_area_exited(area: Area2D) -> void:
#    pass # Replace with function body.

