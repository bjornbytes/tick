lovestep
===

Gives `love.run` superpowers, including a [fixed timestep model](http://gafferongames.com/game-physics/fix-your-timestep/) and framerate limiting.

Usage
---

Copy the `lovestep.lua` file to a project directory and require it, which returns a table that includes all of the functionality.

```
local lovestep = require 'lovestep'

function love.load(arg)
  lovestep.framerate = 60 -- Limit framerate to 60 frames per second.
end
```

Documentation
---

### Properties

These are simple variables that can be set on the `lovestep` table to change its behavior.

- `lovestep.framerate = -1`

Sets the maximum number of frames per second that can occur.  For example, setting framerate to 60 will limit the number of calls to `love.draw` to 60 per second.  Can be set to -1 for unlimited framerate (the default).

- `lovestep.tickrate = .03`

Sets the tick rate of the fixed timestep model (in seconds per tick), which limits the number of calls to `love.update`.  As a consequence, the `dt` argument passed to `love.update` will always be `lovestep.tickrate`.  The default is 33 ticks per second.

- `lovestep.sleep = .001`

The number of milliseconds to sleep at the end of a frame.  The default of .001 is recommended so you're nice to the player's CPU.

### Read-only Values

These are timing values that can be read from the `lovestep` table.  They should only be read, but I guess you can write to them if you want.

- `lovestep.dt`

A read-only value representing the time elapsed since the last frame.  This is *not* the `dt` passed into `love.update`.

- `lovestep.accum`

A read-only value representing an accumulation of time.  In `love.draw` this will always be less than `lovestep.tickrate`.

- `lovestep.tick`

A read-only value representing the current tick.  On the first call to `love.update` this will return 1, on the second call it will return 2, and so on.

- `lovestep.frame`

A read-only value representing the current frame.  On the first call to `love.draw` this will return 1, on the second call it will return 2, and so on.

License
---

MIT, see LICENSE for details.
