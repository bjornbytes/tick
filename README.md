tick
===

Gives `love.run` superpowers, including a [fixed timestep model](http://gafferongames.com/game-physics/fix-your-timestep/) and framerate limiting.

Usage
---

Copy the `tick.lua` file to a project directory and require it, which returns a table that includes all of the functionality.

```lua
local tick = require 'tick'

function love.load(arg)
  tick.framerate = 60 -- Limit framerate to 60 frames per second.
end
```

Documentation
---

### Properties

These are simple variables that can be set on the `tick` table to change its behavior.

- `tick.framerate = -1`

Sets the maximum number of frames per second that can occur.  For example, setting framerate to 60 will limit the number of calls to `love.draw` to 60 per second.  Can be set to -1 for unlimited framerate (the default).

- `tick.rate = .03`

Sets the tick rate of the fixed timestep model (in seconds per tick), which limits the number of calls to `love.update`.  As a consequence, the `dt` argument passed to `love.update` will always be `tick.rate`.  The default is 33 ticks per second.

- `tick.timescale = 1`

Multiplies all time values by this factor.  For example, setting `timescale` to `0.5` could be used for a bullet time effect.

- `tick.sleep = .001`

The number of milliseconds to sleep at the end of a frame.  The default of .001 is recommended so you're nice to the player's CPU.

### Read-only Values

These are timing values that can be read from the `tick` table.  They should only be read, but I guess you can write to them if you want.

- `tick.dt`

A read-only value representing the time elapsed since the last frame.  This is *not* the `dt` passed into `love.update`.

- `tick.accum`

A read-only value representing an accumulation of time.  In `love.draw` this will always be less than `tick.rate`.

- `tick.tick`

A read-only value representing the current tick.  On the first call to `love.update` this will return 1, on the second call it will return 2, and so on.

- `tick.frame`

A read-only value representing the current frame.  On the first call to `love.draw` this will return 1, on the second call it will return 2, and so on.

License
---

MIT, see LICENSE for details.
