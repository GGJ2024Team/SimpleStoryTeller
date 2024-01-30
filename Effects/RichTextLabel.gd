extends RichTextLabel

var emojis = Emojis.new()
export var text_with_emojis := ":sunglasses:"
 
func _ready():
    bbcode_enabled = true
    bbcode_text = emojis.parse_emojis(text_with_emojis)
