# Warning: this tweetcart makes use of the advanced 'double-buffer' technique
# so it's not easy to follow.
# The order that primitives are created and output follows the order in the
# tweetcart which doesn't make obvious sense. Primitives (solids) are being
# added to the buffer after the buffer is rendered. The "final" output to the
# screen happens on the following tick.

def tick args
  args.outputs.background_color = [0, 0, 0]

  # setup things that run only once
  if args.tick_count.zero?
    # create the first target buffer symbols
    args.state.buffer_a = :symbol_1
    args.state.buffer_b = :symbol_2

    # initialize the first render target
    args.render_target(args.state.buffer_a)
  end

  # flip the render targets every tick
  args.state.buffer_a, args.state.buffer_b = args.state.buffer_b, args.state.buffer_a 

  # copy the texture of the non-active buffer to the active buffer
  # rotate it by 45 degrees to create the rotational pattern
  args.render_target(args.state.buffer_a).sprites << {
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: args.state.buffer_b,
    angle: 45 # this angle makes the rotational pattern
  }

  # output the texture of the non-active buffer to the screen
  args.outputs.sprites << {
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: args.state.buffer_b
  }

  # add primitives to the active buffer

  # move the primitive in a small circle
  # moves the primitive gently left and right
  x = 600 + args.tick_count.sin * 25
  # moves the primitive gently up and down
  y = d = 300 + args.tick_count.cos * 25

  # makes the primitive width move smoothly back and forth
  # from about -10 to 10 pixels in width
  w = args.tick_count.cos * 10

  # makes the primitive width move smoothly back and forth
  # from about -100 to 100 pixels in height
  h = args.tick_count.sin * 100

  # adds red when the primitive is widest
  red = Math.atan(args.tick_count.cos) * y

  # adds green based on strength of red and x position
  green = red + args.tick_count.sin * 255

  # draw to the buffer
  args.render_target(args.state.buffer_a).primitives << {
    x: x,
    y: y,
    w: w,
    h: h,
    r: red,
    g: green
  }.solid
end