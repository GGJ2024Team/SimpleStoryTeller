extends TextureButton

onready var info_rect = $Info 
onready var label = $Label
export(String) var info
var icon_path = "res://Assets/Scenes/EmpytScene2.png"
func _ready() -> void:
    label.text = info
    info_rect.texture = load(icon_path)

func set_label_text(t):
    info = t
    
func set_label_icon(path):
    icon_path = path
    
func _on_InfoButton_mouse_entered() -> void:
    info_rect.visible = true
    label.visible = true

func _on_InfoButton_mouse_exited() -> void:
    info_rect.visible = false
    label.visible = false
