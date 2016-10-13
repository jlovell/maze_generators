require_relative 'binary_tree'
require_relative 'recursive'

class Maze
  N, S, E, W      = 1, 2, 4, 8
  DIRECTION_NAMES = { north: N, south: S, east: E, west: W }
  DX              = { E => 1, W => -1, N =>  0, S => 0 }
  DY              = { E => 0, W =>  0, N => -1, S => 1 }
  OPPOSITE        = { E => W, W =>  E, N =>  S, S => N }

  attr_reader :width, :height, :grid

  def initialize(width = 10, height = 10, seed = rand(0xFFFF_FFFF))
    @width  = width.to_i
    @height = height.to_i
    srand(seed.to_i)

    @grid = Array.new(height) { Array.new(width, 0) }
  end

  def carve(x_current, y_current, direction_name)
    x_next, y_next = next_coordinates(x_current, y_current, direction_name)
    direction = DIRECTION_NAMES[direction_name]

    grid[y_current][x_current] |= direction
    grid[y_next][x_next] |= OPPOSITE[direction]
  end

  def next_coordinates(x_current, y_current, direction_name)
    direction = DIRECTION_NAMES[direction_name]
    [x_current + DX[direction], y_current + DY[direction]]
  end

  def draw
    print "\e[H" # move to upper-left
    puts " " + "_" * (grid[0].length * 2 - 1)
    grid.each_with_index do |row, y|
      print "|"
      row.each_with_index do |cell, x|
        if cell == 0 && y+1 < grid.length && grid[y+1][x] == 0
          print " "
        else
          print((cell & S != 0) ? " " : "_")
        end

        if cell == 0 && x+1 < row.length && row[x+1] == 0
          print((y+1 < grid.length && (grid[y+1][x] == 0 || grid[y+1][x+1] == 0)) ? " " : "_")
        elsif cell & E != 0
          print(((cell | row[x+1]) & S != 0) ? " " : "_")
        else
          print "|"
        end
      end
      puts
    end
  end

end

Recursive.(Maze.new)
