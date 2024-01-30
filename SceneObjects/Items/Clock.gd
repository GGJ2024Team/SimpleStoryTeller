extends Item


var is_get_stage_pre_show = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func _input(event: InputEvent) -> void:
    if placed and mouse_in_range and event.is_action_released("ui_accept") and is_interact_mode():
        print("Hello Clock")
        if is_get_stage_pre_show == false:
            is_get_stage_pre_show = true
            self.visible = false
            add_button("StagePreShow","res://Assets/SceneObjects/Items/clock.png","舞台未表演")#此处插入获得StagePreShow
            yield(get_tree().create_timer(0.1),"timeout")
            self.visible = true
            

