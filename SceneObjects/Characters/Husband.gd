extends Character

func _init_attrs():
    attr["get_card"] = false
    attr["get_wallet"] = false
    attr["get_key"] = false
    attr["get_phone"] = false
    attr["get_clothes"] = false
    attr["wife_help"] = false
    attr["hug_wife"] = false
    attr["on_time"] = false
    
    attr["has_hair"] = false
    attr["has_rope"] = false
    attr["has_stick"] = false
    attr["has_scratcher"] = false
    
    attr["get_cactus"] = false
    attr["bite_self"] = false
    attr["bite_boss"] = false
    attr["fired"] = false

    
func _update_attr(scene_objs):
    match scene_name:
        "LivingRoom2":
            print(attr["get_card"],attr["get_wallet"],attr["get_key"],attr["get_phone"],attr["get_clothes"])
            print("update_attr of : ", obj_name, " in :", scene_name)
            print("==== scene objs =====")
            for k in scene_objs:
                print(k)
            if scene_objs.has("Wife"):
                var wife = scene_objs["Wife"]
                var wife_animatedsprite = wife.get_node("AnimatedSprite")
                var wife_animationplayer = wife.get_node("AnimationPlayer")
                if attr["wife_help"]:
                    attr["on_time"] = true
                    wife.set_mood("angry",true,Vector2(60,-100))
                    wife_animationplayer.play("angry_woman")
                    self.set_mood("scaled")
                    print("通关")
                elif attr["get_card"] and attr["get_wallet"] and attr["get_key"] and attr["get_phone"] and attr["get_clothes"]:
                    attr["on_time"] = true
                    print("通关")
                    if attr["hug_wife"]:
                        self.visible = false
                        wife_animationplayer.play("hug")
                        yield(get_tree().create_timer(1.5),"timeout")
                        wife.set_mood("laugh")
                        
        "Bus":
            print("update_attr of : ", obj_name, " in :", scene_name)
            print("==== scene objs =====")
            for k in scene_objs:
                print(k)
            if attr["has_hair"] and attr["has_rope"] and attr["has_stick"]:
                get_anchors().get_node("Anchor6").visible = true
            if attr["has_scratcher"]:
                print(get_scene().scene_name)
                get_scene().get_node("Sprite").visible = false
                get_scene().get_node("Node2D/Sprite").visible = false
                
                print("拯救公交车")
                self.set_mood("laugh")
        "Company":
#            print("update_attr of : ", obj_name, " in :", scene_name)
#            print("==== scene objs =====")
#            for k in scene_objs:
#                print(k)
            if(attr["fired"]):
                var text_bubble = load("res://Effects/TextBubble.tscn").instance()
                text_bubble.set_text("你被开除了！")
                add_child(text_bubble)
                text_bubble.position = Vector2(30,-50)
                text_bubble.play()
                yield(get_tree().create_timer(1.5),"timeout")
                self.set_mood("sad")
                print("loss,被公司开除")
            elif attr["bite_self"] and attr["bite_boss"]:
                
                get_scene().get_node("Anchors/Anchor5/Boss/AnimationPlayer").play("shine")
                self.get_node("AnimationPlayer").play("shine")
                yield(get_tree().create_timer(1.5),"timeout")
                var text_bubble = load("res://Effects/TextBubble.tscn").instance()
                text_bubble.set_text("身份互换，我当老板啦")
                add_child(text_bubble)
                text_bubble.position = Vector2(30,-50)
                text_bubble.play()
                yield(get_tree().create_timer(1.5),"timeout")
                self.set_mood("success",true,Vector2(60,-100))
                var eff = load("res://Effects/Fireworks.tscn").instance()
                add_child(eff)
                eff.start()

func _input(event: InputEvent) -> void:
    match scene_name:
        "LivingRoom2":
            var text_bubble = load("res://Effects/TextBubble.tscn").instance()
            if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
                text_bubble.set_text("快迟到了，帮我拿一下东西")
                add_child(text_bubble)
                text_bubble.position = Vector2(30,-50)
                text_bubble.play()
