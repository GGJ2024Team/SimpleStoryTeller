extends Character

func _update_attr(scene_objs):
    match GameData.current_level:
        6: 
            state_machine_level_6(scene_objs)
            
func state_machine_level_6(scene_objs):
    match scene_name:
        "Kitchen":
            add_button("Dumpling")
