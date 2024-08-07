# Architecture

Scenes:

- Main-Menu:
    ...
- Game:
    - Meta-Progression: The Meta-Progression scene is the main container for all levels and all information accross levels. This scene manages loading of levels and transitions between them. Level transitions are encoded in a json-file to help with parametrization by non-coders.

- Level:
    - "Abstract scene"
    - Inherited by every level to add base functionality for transitions, loading, etc.
