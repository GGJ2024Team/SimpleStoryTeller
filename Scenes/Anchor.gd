extends Position2D

onready var button = $AnchorButton

func _ready() -> void:
    if get_child_count() > 1:
        disable()
        for c in get_children():
            if c.get_name() != "AnchorButton":
                c.placed = true
                
func get_scene():
    return get_parent().get_parent()
                    
func get_scene_area_idx():
    return get_parent().get_parent().get_scene_area_idx()
    
func enable():
    button.disabled = false
    button.visible = true
    
func disable():
    button.disabled = true
    button.visible = false
