extends Node
class_name BossStatesKeeper

@export var states : Array[BossState]

var currentState : BossState

func update(delta: float):
	changeState(currentState.updateState(delta))

func changeState(inputState : BossState):
	if inputState == null:
		return
	currentState.exitState()
	currentState = inputState
	currentState.enterState()
