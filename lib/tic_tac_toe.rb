require "pry"
class TicTacToe

    attr_accessor :index, :token, :x_array, :o_array

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5], # Middle row
        [6,7,8], # bottom row
        [2,5,8],
        [1,4,7],
        [0,3,6],
        [0,4,8],
        [2,4,6]
        # et cetera, creating a nested array for each win combination
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(str)
        str.to_i-1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(position)
        position < @board.length && !position_taken?(position)
    end

    def turn_count
        @board.join("").scan(/[XO]/).length
    end

    def current_player
        if turn_count % 2 == 0
            return "X"
        else
            return "O"
        end
    end


    def turn
        index = input_to_index(gets)
        if valid_move?(index)
            move(index, current_player)
            display_board
        elsif !valid_move?(index)
            index = input_to_index(gets)
        end
    end

        # binding.pry
=begin         user_index = 0
        until valid_move?(user_index)
            user_index = input_to_index(gets)
        end

        if valid_move?(user_index)
            move(user_index, current_player)
            display_board
        end
    end
=end

    def taken_spaces
        @x_array = @board.each_index.select { |index| @board[index] == "X"}
        @o_array = @board.each_index.select { |index| @board[index] == "O"}
    end



    def won?
        taken_spaces
#binding.pry

        WIN_COMBINATIONS.each do |combo|
            if (@x_array & combo) == combo
                return combo
            elsif (@o_array & combo) == combo
                return combo
            else
                return false
            end
        end
    end


    def full?
        taken_spaces
        if @x_array.length + @o_array.length == 9
            true
        else
            false
        end
    end

    def draw?
        taken_spaces
        if full?
            if won? == false
                true
            else
                false
            end
        else
            false
        end    
    end

    def over?
        won? or full?
    end

    def winner
        taken_spaces

        if won?.find(@x_array.sort)
            "X"
        elsif won?.find(@o_array.sort)
            "O"
        else
            nil
            binding.pry
        end
    end

=begin     def play
        while !over?
            turn
            won?
            draw?
        end

    end
=end
end
