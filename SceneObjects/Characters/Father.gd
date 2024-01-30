extends Character

func _init_attrs():
    match GameData.current_level:
        1:
            attr["know_about_the_special_day"] = false
            attr["have_diamond"] = false
            attr["have_flower"] = false
            attr["have_extra_money"] = false
    
func state_machine_level_1(scene_objs):
    match scene_name:
        "LivingRoom":
            print("hello living room")
            if scene_objs.has("Mother"):
                print("hello mother")
                var mother = scene_objs["Mother"]
                if !attr["know_about_the_special_day"]:
                    attr["know_about_the_special_day"] = true
                    self.set_mood("surprised")
                    print_attr()
                else:
                    if attr["have_diamond"]:
                        mother.set_mood("happy")
                    elif attr["have_flower"]:
                         mother.set_mood("normal")                                        
        "Bathroom":
            print("hello bathroom")
            print_attr()
            if attr["know_about_the_special_day"] and !attr["have_extra_money"]:
                attr["have_extra_money"] = true
                self.set_mood("hesitate")
        "Shop":
            if scene_objs.has("LittleSister"):
                scene_objs["LittleSister"].set_mood("happy")
            elif attr["know_about_the_special_day"] and  attr["have_extra_money"]:
                attr["have_diamond"] = true
                attr["have_extra_money"] = false
            elif attr["know_about_the_special_day"] and  !attr["have_extra_money"]:
                attr["have_flower"] = true

func state_machine_level_6(scene_objs):
    pass
    
func _update_attr(scene_objs):
    match GameData.current_level:
        1: 
            state_machine_level_1(scene_objs)
        6: 
            state_machine_level_6(scene_objs)
            
        
func _input(event: InputEvent) -> void:
    match GameData.current_level:
        6:
            if placed and overlapping_obj != null and event.is_action_released("ui_interact") and !is_interact_mode():
                if overlapping_obj.obj_name == "Dumpling":
                    set_mood("happy")
    
