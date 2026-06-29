class_name DialogueLibrary extends Resource




@export var greetings: Array[Greeting]

@export var branches: Array[DialogueBranch]







# When starting dialogue, always begin with a Greeting except when a branch greeting_override == true