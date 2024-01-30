extends Character

signal start_rain

func _init_attrs():
    attr["have_dumpling_wrappers"] = false #是否从饺子之神那里得到饺子皮的力量
    attr["have_dumpling_filling"] = false #是否从饺子之神那里得到饺子馅的力量
    attr["have_new_screen"] = null #是否得到过新场景

func _update_attr(scene_objs):
    print("update_attr of : ", obj_name, " in :", scene_name)
    print("==== scene objs =====")
    for k in scene_objs:
        print(k)
    match scene_name:
        "Stage":
            print("hello Stage")
            print_attr()
            if scene_objs.has("Performer") and scene_objs.has("Audience"):
                if is_stage_right_place() and scene_objs["Audience"].is_stage_right_place():
                    if attr["have_dumpling_wrappers"] == false and attr["have_dumpling_filling"] == false:
                        self.set_mood("hesitate")
                        scene_objs["Audience"].set_mood("hesitate")
                    elif attr["have_dumpling_wrappers"] == true and attr["have_dumpling_filling"] == false:
                        var anchor_dumplingWrappers = preload("res://Scenes/Anchor.tscn").instance()
                        var dumplingWrappers: Item = preload("res://SceneObjects/Items/DumplingWrappers.tscn").instance()
                        anchor_dumplingWrappers.add_child(dumplingWrappers)
                        get_scene().get_node("Anchors").add_child(anchor_dumplingWrappers)
                        anchor_dumplingWrappers.global_position = self.global_position
                        print("display 催眠笑")
                        dumplingWrappers.get_node("AnimationPlayer").play("hypnosis")
                        
                        self.set_mood("normal")
                        scene_objs["Audience"].start_hy()
                        scene_objs["Audience"].set_mood("happy")
                        pass #display 催眠笑
                    elif attr["have_dumpling_wrappers"] == false and attr["have_dumpling_filling"] == true :
                        var anchor_dumplingFilling = preload("res://Scenes/Anchor.tscn").instance()
                        var dumplingFilling: Item = preload("res://SceneObjects/Items/DumplingFilling.tscn").instance()
                        anchor_dumplingFilling.add_child(dumplingFilling)
                        get_scene().get_node("Anchors").add_child(anchor_dumplingFilling)
                        anchor_dumplingFilling.global_position = self.global_position
                        self.visible = false
                        dumplingFilling.get_node("AnimationPlayer").play("kongfu")
                        yield(get_tree().create_timer(4),"timeout")
                        self.set_mood("normal")                        
                        scene_objs["Audience"].set_mood("happy")
                        pass #display 表演武术笑
                    elif attr["have_dumpling_wrappers"] == true and attr["have_dumpling_filling"] == true:
                        var anchor_dumplingWrappers = preload("res://Scenes/Anchor.tscn").instance()
                        var dumplingWrappers: Item = preload("res://SceneObjects/Items/DumplingWrappers.tscn").instance()
                        anchor_dumplingWrappers.add_child(dumplingWrappers)
                        get_scene().get_node("Anchors").add_child(anchor_dumplingWrappers)
                        anchor_dumplingWrappers.global_position = self.global_position
                        var anchor_dumplingFilling = preload("res://Scenes/Anchor.tscn").instance()
                        var dumplingFilling: Item = preload("res://SceneObjects/Items/DumplingFilling.tscn").instance()
                        anchor_dumplingFilling.add_child(dumplingFilling)
                        get_scene().get_node("Anchors").add_child(anchor_dumplingFilling)
                        anchor_dumplingFilling.global_position = self.global_position
                        anchor_dumplingFilling.global_position.x = anchor_dumplingFilling.global_position.x +20
                        self.visible = false
                        print("display 催眠笑")
                        dumplingWrappers.get_node("AnimationPlayer").play("hypnosis")
                        dumplingFilling.get_node("AnimationPlayer").play("kongfu")
                        yield(get_tree().create_timer(4),"timeout")
                        self.visible = true
                        dumplingWrappers.visible = false
                        dumplingFilling.visible = false
                        emit_signal("start_rain")
                        self.set_mood("tasty")
                        scene_objs["Audience"].set_mood("tasty")
                        yield(get_tree().create_timer(1),"timeout")
                        self.set_mood("happy")
                        scene_objs["Audience"].set_mood("happy")
                        pass #display 饺子龙卷风给每个人吃，一起笑
        "StagePreShow":
            print("hello StagePreShow")
            if scene_objs.has("Performer") and is_stage_pre_show_right_place() and scene_objs.has("Dumpling2") and scene_objs["Dumpling2"].is_stage_pre_show_right_place():
                print("hello Dumpling2")
                                      
        "DumplingGod":
            print("hello DumplingGod")
            print_attr()

func is_stage_right_place():
    if self.get_anchor_name() == "UpPos":
        return true
    else:
        return false
        
func is_stage_pre_show_right_place():
    if self.get_anchor_name() == "DownPos":
        return true
    else:
        return false
    
    
