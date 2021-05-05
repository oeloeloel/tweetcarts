def tick args

  # set the background colour
  args.outputs.background_color = [210, 260, 255]

  # setup things that happen once
  if args.tick_count.zero?

    # counts frames. This could have been done with
    # args.tick_count but the tweetcart code sets and
    # increments a variable to be extra short
    args.state.counter = 0

    # make a plain white texture to use for the squares
    args.render_target(:rectangle).solids << {
      x: 0,
      y: 0,
      w: 1280,
      h: 720,
      r: 255,
      g: 255,
      b: 255
    }
  end

  # increment the counter every frame
  args.state.counter+=1

  # step counts from the first number to the second number
  # in steps of the third number. In the following code, we
  # loop through the whole screen setting sprites 40 pixels
  # apart, horizontally and vertically
  0.step(1280, 40) do |x|
    0.step(720, 40) do |y|

      # squares rotate at different rates and directions
      # depending on their location on the screen
      angle = (x + y).sin * args.state.counter * 2

      # set colours
      # red moves to the right and turns dark towards the bottom
      red = (x - args.state.counter).sin * y

      # green moves to the left and turns dark towards the bottom
      green = (x + args.state.counter).cos * (y / 3)

      # blue does not move but turns dark towards the bottom
      blue = y / 3

      args.outputs.sprites << {
        x: x,
        y: y,
        w: 40, # squares
        h: 40,
        path: :rectangle,
        angle: angle,
        a: 255, # no alpha
        r: red,
        g: green,
        b: blue
      }
    end
  end
end