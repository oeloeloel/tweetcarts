def tick args
  args.outputs.background_color = [0, 0, 0]
  
  # setup the things that need to be done only once
  args.state.counter ||= 0

  # count up and down in tiny steps
  args.state.counter += args.tick_count.cos / 1000

  # draw a grid of dots on the screen, 12 pixels apart
  100.step(600, 12) do |y|
    100.step(600, 12) do |x|

      # makes dark horizontal lines that expand and contract
      pattern_1 = Math.sin(y * args.state.counter)

      # makes dark vertical lines that roll right and left
      pattern_1 += (Math.cos(x))
      
      # scale the pattern values up so we can see them
      pattern_1 *= 200

      # the above lines combine to make a diamond pattern
      # that does gymnastics around the screen

      # the next lines do the same thing but with x and y reversed
      # to get the same pattern moving in a different direction

      pattern_2 = Math.sin(x*args.state.counter)
      pattern_2 += (Math.cos(y))
      pattern_2 *= 200

      # combine the patterns for the colours
      # abs forces the colours to have positive
      # values and that makes the bright interiors to the shapes
      red = (pattern_1 + pattern_2).abs - 10
      green = (pattern_1 - pattern_2).abs - 50
      blue = green

      #make coloured squares
      args.outputs.solids << {
        x: x,
        y: y,
        w: 8,
        h: 8,
        r: red,
        g: green,
        b: blue
      }
    end
  end
end