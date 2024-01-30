extends RichTextLabel

var emojis = Emojis.new()
func _ready():
    bbcode_enabled = true

func set_text(text_with_emojis:String):
    bbcode_text = emojis.parse_emojis(text_with_emojis)
    
