# Warning: this tweetcart makes use of the advanced 'double-buffer' technique
# so it's not easy to follow. Also, better examples show up in later tweets
# (largely thanks to HIRO-R-B).

def tick args
  # set up the things that happen only once
  if args.tick_count.zero?
    # double buffer alternates between two render targets (buffers) each tick
    # this tracks which one is currently active
    args.state.active_buffer = :buffer_b

    # create the buffers
    args.render_target(:buffer_a)
    # note, in the tweetcart, buffer_b is created when it is first used
    args.render_target(:buffer_b)

    # create a rectangular texture to avoid importing an external file
    args.render_target(:rectangle).solids << {
      x: 0,
      y: 0,
      w: 1280,
      h: 720
    }

    # make a circle texture by rotating the rectangle through 90 degrees
    args.render_target(:circle).sprites << 90.times.map do |angle|
      {
        x: 20, # leave some space or the rotated sprite will get clipped
        y: 20,
        w: 20,
        h: 20,
        path: :rectangle,
        angle: angle
      }
    end
  else
    # draw if the left mouse button is down
    if args.inputs.mouse.button_left
      # figure out where to put the circle sprite based on the
      # mouse location. Shift it so the mouse location is
      # approximately in the middle of the sprite
      x = args.inputs.mouse.x - 30
      y = args.inputs.mouse.y - 30
      
      # draw into the currently active buffer
      args.render_target(args.state.active_buffer).sprites << {
        x: x,
        y: y,
        w: 1280,
        h: 720,
        path: :circle
      }
    end

    # we need to flip the active buffer from a to b or b to a every tick
    # get ready to change it but don't flip it yet
    if args.state.active_buffer == :buffer_a
      non_active_buffer = :buffer_b # temp variable
    else
      non_active_buffer = :buffer_a
    end

    # draw the non-active buffer into the active buffer
    args.render_target(args.state.active_buffer).sprites << [
      0,
      0,
      1280,
      720,
      non_active_buffer
    ]

    # now flip the buffers
    args.state.active_buffer = non_active_buffer

    # output the newly active buffer to the screen
    args.sprites << {
      x: 0,
      y: 0,
      w: 1280,
      h: 720,
      path: args.state.active_buffer
    }
  end

  # clear one of buffers when the right mouse button is clicked
  if args.inputs.mouse.button_right
    # it's a bit of a hack
    args.render_target(:buffer_a).w = 1
  end
end