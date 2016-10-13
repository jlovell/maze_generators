class Recursive
  def self.call(grid)
    y_current, x_current = rand(grid.height), rand(grid.width)
    visited = []

    loop do
      visited << [x_current, y_current]
      direction = loop do
        available_directions = [
          (:north if y_current > 0),
          (:west if x_current > 0),
          (:south if y_current < (grid.height - 1)),
          (:east if x_current < (grid.width - 1)),
        ].compact
        puts [x_current, y_current, available_directions].inspect
        dir = available_directions.sample
        if dir
          if !visited.include?(grid.next_coordinates(x_current, y_current, dir))
            puts dir.inspect
            break dir
          end
        else
          grid.draw; return
        end
      end
      grid.carve(x_current, y_current, direction)
      x_current, y_current = grid.next_coordinates(x_current, y_current, direction)
    end
  end

end
