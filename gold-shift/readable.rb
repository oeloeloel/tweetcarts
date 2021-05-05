
def tick args
  args.outputs.background_color = [0, 0, 0]
  
  # setup the things that need to be done only once
  args.state.counter ||= 0
  B||=0

  # count upwards in very tiny steps
  args.state.counter += args.tick_count.cos / 1000
  B += args.tick_count.cos/1000

  # draw a grid of dots in the middle of the screen, 12 pixels apart
  110.step(610, 12) do |y|
    390.step(890, 12) do |x|

      # makes dark horizontal lines that expand and contract
      red = Math.sin(y * args.state.counter)

      # makes dark vertical lines that roll right and left
      red += Math.cos(x - args.state.counter)

      # the above 2 lines combine to make a diamond pattern
      # that does gymnastics around the screen

      # the next 2 lines do the same thing but with x and y reversed
      # to get the same pattern moving in a different direction
      red += Math.sin(x * args.state.counter)
      red += Math.cos(y - args.state.counter)

      # force r to be positive (this makes bright interiors to the shapes)
      red = red.abs

      # magnify it so we can see it
      red *= 200

      # make the other colours the same but darker
      green = red / 2
      blue = red / 3

      #make coloured squares
      args.outputs.solids << {
        x: x,
        y: y,
        w: 6,
        h: 6,
        r: red,
        g: green,
        b: blue
      }
    end
  end
end