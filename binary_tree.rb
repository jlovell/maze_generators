class BinaryTree
  def self.call(grid)
    grid.height.times do |y_current|
      grid.width.times do |x_current|
        sleep 0.02

        available_directions = []
        available_directions << :north if y_current > 0
        available_directions << :west if x_current > 0

        unless available_directions.empty?
          grid.carve(x_current, y_current, available_directions.sample)
        end
        grid.draw
      end
    end
  end
end
