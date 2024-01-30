extends Node2D

onready var bg = $Background
onready var text_label = $Label
onready var tween = $Tween

var bubble_text = "Nothing to say"
var bubble_last_sec = 3

func _ready() -> void:
#    bg.rect_size = text_label.rect_size
    text_label.text = bubble_text
    
    
func set_text(t):
    bubble_text = t
    
func show():
    visible = true
    
func hide():
    visible = false
    
func play(last_sec:float = 3):
    show()
    play_anime(last_sec)
#    hide()
    
func play_anime(last_sec):
    tween.interpolate_property(self,
            "modulate:a",
            1.0,
            0.0,
            last_sec,
            Tween.TRANS_LINEAR,
            Tween.EASE_OUT
        )
    
    tween.start()
   
func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
    queue_free()
