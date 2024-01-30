extends Character
var click = 0


func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        var scene: MyScene = get_parent().get_parent().get_parent()
        print(scene.scene_objects["Husband"].attr["on_time"])
        var text_bubble = load("res://Effects/TextBubble.tscn").instance()
        
        if scene.scene_objects["Husband"].attr["on_time"] and click<5:
            scene.scene_objects["Husband"].attr["hug_wife"] = true
            print(get_scene())
            get_scene().update_scene()
        else:
            click += 1
            match click:
                1:  
                    text_bubble.set_text("干嘛")
                    add_child(text_bubble)
                    text_bubble.position = Vector2(30,-50)
                    text_bubble.play()
                2:  
                    text_bubble.set_text("东西都乱放")
                    add_child(text_bubble)
                    text_bubble.position = Vector2(30,-50)
                    text_bubble.play()
                3:  
                    text_bubble.set_text("自己不会找吗")
                    add_child(text_bubble)
                    text_bubble.position = Vector2(30,-50)
                    text_bubble.play()
                4:  
                    text_bubble.set_text("每次都要我帮你")
                    add_child(text_bubble)
                    text_bubble.position = Vector2(30,-50)
                    text_bubble.play()
                5:
                    scene.scene_objects["Husband"].attr["wife_help"] = true  
                    print("妻子帮助丈夫")
                

            print(click)
            get_scene().update_scene()

