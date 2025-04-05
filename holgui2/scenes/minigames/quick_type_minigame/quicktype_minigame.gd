extends Minigame
class_name Quicktype_minigame

var words = ["door", "a", "mark", "emerald", "pale"]

var currentWord = ""

var rng = RandomNumberGenerator.new()
	
func enter():
	pass
	
func physics_update(_delta: float) -> void:
	$typed_word.grab_focus()
	if currentWord == "":
		var random = rng.randf_range(0,words.size())
		currentWord = words[random]
		$word_to_type.text = currentWord
		
	if($word_to_type.text == $typed_word.text): #won
		var random = rng.randf_range(0,words.size())
		currentWord = words[random]
		$word_to_type.text = currentWord
		$typed_word.text = ""
		minigame_finished.emit(self)
