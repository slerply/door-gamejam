extends Minigame
class_name Math_minigame


var sum1 = 0
var sum2 = 0
var solutionToGet = 0

var rng = RandomNumberGenerator.new()
	
func enter():
	pass
	
func physics_update(_delta: float) -> void:
	$solution.grab_focus()
	if solutionToGet == 0:
		sum1 = rng.randi_range(1,30)
		sum2 = rng.randi_range(1,30)
		solutionToGet = sum1 + sum2
		$question.text = str(sum1) + " + " + str(sum2) +" = "
		
	if($solution.text == str(solutionToGet)): #won
		sum1 = rng.randi_range(1,30)
		sum2 = rng.randi_range(1,30)
		solutionToGet = sum1 + sum2
		$question.text = str(sum1) + " + " + str(sum2) +" = "
		$solution.text = ""
		minigame_finished.emit(self)
