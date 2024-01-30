extends Item

onready var ap = $AnimatedSprite

func _ready() -> void:
    ap.play("default")
    
func _update_attr(scene_objects):
    match scene_name:
        "Forest":
            ap.play("blink")
        _:
            ap.play("default")
            
func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        add_button("SpringOnionSeed", "res://Assets/SceneObjects/Items/rose_seed.png", "葱种子")
