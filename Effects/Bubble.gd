extends Sprite

onready var emoji = $EmojiRect
onready var tween = $Tween

var emoji_path = "res://Assets/Effects/bubble.png"
var bubble_last_sec = 1
func _ready() -> void:
    set_emoji(emoji_path)
    play(bubble_last_sec)
    
func set_pos(new_pos):
    position = new_pos
    
func set_emoji(path):
    print(emoji == null)
    emoji.texture = load(path)
    
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
