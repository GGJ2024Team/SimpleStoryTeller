extends Character

onready var hy = [$AnimatedSprite/Audience, $AnimatedSprite/Audience2, $AnimatedSprite/Audience3, $AnimatedSprite/Audience4]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
func is_stage_right_place():
    if self.get_anchor_name() == "DownPos":
        return true
    else:
        return false

func start_hy():
    for i in hy:
        i.get_node("AudienceHy").visible = true
