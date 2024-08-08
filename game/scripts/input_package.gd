class_name InputPackage extends Node

# Don't forget to call queue_free() on this object when you are done using it.
# Otherwise these input packages will accumulate over time -> memory leak

# x-axis input (negative is left, positive is right)
var direction: float
# A list of actions, the player wants to perform
var actions: Array[String] = []
