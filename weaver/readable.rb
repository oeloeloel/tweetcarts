# "Weaver" TweetCart
# More readable version

def tick args
  # set the background colour
  args.outputs.background_color = [0, 0, 0]
  
  ################################
  # set initial variables one time

  # number of lines to draw
  # 360 lines makes a complete circle. Try setting this to 45
  # to get a better idea of what's happening
  args.state.number_of_lines ||= 360

  args.state.counter ||= 0 # counts upward in tiny fractions
  center_x ||= 640 # center of the circles
  center_y ||= 380 # center of the circles

  # try changing these
  outer_radius ||= 300 # radius of the big circle
  inner_radius ||= 150 # radius of the small circle
  #################################################

  # make the lines
  args.state.number_of_lines.times do |line_num|

    # the lines all start at points around the outer circumference
    x = line_num.sin * outer_radius + center_x
    y = line_num.cos * outer_radius + center_y

    # the line ends rotate at different speeds around the inner circle
    args.state.counter += 0.000001
    x2 = Math.cos(line_num * args.state.counter) * inner_radius + center_x
    y2 = Math.sin(line_num * args.state.counter) * inner_radius + center_y

    # output the lines
    args.outputs.lines << {
      x: x,
      y: y,
      x2: x2,
      y2: y2,
      r: 255,
      b: 255,
      g: 255
    }
  end
end