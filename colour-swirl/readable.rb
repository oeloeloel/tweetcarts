def tick args
  # do the things that only need to happen once
  if args.tick_count.zero?
    
    # make a rectangle using a render target
    # this allows us to make rectangular sprites
    # that can rotate, without using any external
    # resources
    # The rectangle is painted white so we can
    # re-colour it later
    args.render_target(:rect).solids << {
      x: 0,
      y: 0,
      w: 1280,
      h: 720,
      r: 255,
      g: 255,
      b: 255
    }

    # when we rotate the rectangles, this is the
    # angle they will have
    args.state.angle = 0

    # governs the size of the overall circle
    args.state.radius = 255
  end

  # increment the angle variable
  # increase the number to speed things up
  args.state.angle += 1.57

  # draw 360 sprites
  args.sprites << 360.times.map do |i|

  # every sprite stays in the same place
  # each sprite has it's own width and height.
  # only the angle changes every tick
  width = Math.sin(i) * args.state.radius
  height = Math.cos(i) * args.state.radius

  # this makes each rectangle barely visible
  # but if you layer them, they become more
  # visible. This is what creates the illusion
  # of the soft edges
  alpha = 10

  # the colours are derived from the width
  # and height of each sprite
  red = 255 - 255 * Math.atan(width)
  green = 255 * Math.atan(width + height)
  blue = 255 - 255 * Math.atan(height)

  # make a sprite
  {
    x: 640, # the middle
    y: 360,
    w: width,
    h: height,
    path: :rect,
    angle: args.state.angle,
    a: alpha,
    r: red,
    g: green,
    b: blue
  }
  end
end