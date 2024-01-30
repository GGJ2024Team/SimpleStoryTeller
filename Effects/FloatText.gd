extends Node2D

onready var tween = $Tween
onready var label = $Label
var text_to_show:String = "None"
var text_size = 20
func _ready() -> void:
    label.text = text_to_show
    spawn(get_global_mouse_position())
    label.set("theme_override_font_sizes/normal_font_size", text_size)
    
func set_text(t):
    text_to_show = t
    
func set_text_size(s):
    text_size = s
    
func spawn(position):
    print("SPAWNING")
    tween.interpolate_property(
            label,
            "modulate:a",
            1.0,
            0.0,
            1.0,
            Tween.TRANS_LINEAR,
            Tween.EASE_OUT
        )
    #位置补间动画
    tween.interpolate_property(
        label,
        "rect_position",
        position,
        position + Vector2(0, -100),
        1.0,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )
    
    tween.start()
    
#func _input(event):
#    if event.is_action_pressed("ui_accept"):
#        spawn(get_global_mouse_position())
   

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
    queue_free() # Replace with function body.
