class ConnectFour
    attr_reader :board, :input, :game_status
    
    def initialize
        @input = ""
        @board = Array.new(8) { Array.new(8) { |c| c = " "} }
        @game_status = true
        @full_columns = []
        @row = nil
        @col = nil
    end

    def print_board
        @board.each do |r|
            print "|"
            r.each do |c|
                if c == " "
                    print " |"
                else
                    print "#{c}|"
                end
            end
            puts ""
            p "-"*16
        end
    end

    def game_on
        while @game_status
            if @full_columns.length == 8
                @game_status = false
                p "Game over..."
                break
            end
            print_board
            while @input != "b" && @input != "y" && @input != "q" 
                p "input color: b/y (to exit input 'q')"
                @input = gets.chomp
                @input.downcase!
            end
            if @input == "q"
                @game_status = false
                break
            end
            p "input position: 0-7"
            pos = gets.chomp
            while pos.match(/\D/) || pos.to_i < 0 || pos.to_i > 7 || @full_columns.include?(pos.to_i)
                p "input position: 0-7"
                pos = gets.chomp
            end
            place_color(@input,pos.to_i)
            @input = ""
            @row = nil
            @col = nil
        end
    end

    def place_color(color,pos)
        i = 7
        while i >= 0
            if @board[i][pos] == " "
                @board[i][pos] = color
                @full_columns << pos if i == 0
                @row = i
                @col = pos
                connected_four?
                return @board[i][pos]
            else
                i -= 1
            end
        end
    end

    def clear_checking_arr(arr)
        return arr if arr.length <= 4 
        temp = arr.slice(0,4)
        return temp if temp.all? { |a| a == "b" } || temp.all? { |a| a == "y" }  
        b = 0
        i = 4
        while i <= arr.length
            temp = arr.slice(b,i)
            return temp if temp.all? { |a| a == "b" } || arr.all? { |a| a == "y" }
            i += 1
            b += 1
        end
        return arr 
    end

    def connected_four?  
        row_check = [@row-3,@row-2,@row-1,@row,@row+1,@row+2,@row+3].select { |e| e >= 0 && e < 8 }
        row_check.map! { |i| @board[i][@col] }
        row_check = clear_checking_arr(row_check)
        if (row_check.all? { |i| i == "b" } || row_check.all? { |i| i == "y" }) && row_check.length == 4
            @game_status = false
            p "We have a winner!!!"
            return true
        end
        col_check = [@col-3,@col-2,@col-1,@col,@col+1,@col+2,@col+3].select { |e| e >= 0 && e < 8 }
        col_check.map! { |i| @board[@row][i] }
        col_check = clear_checking_arr(col_check)
        if (col_check.all? { |i| i == "b" } || col_check.all? { |i| i == "y" }) && col_check.length == 4
            @game_status = false
            p "We have a winner!!!"
            return true
        end
        cross_check_1 = [[@row-3,@col-3],[@row-2,@col-2],[@row-1,@col-1],[@row,@col],[@row+1,@col+1],[@row+2,@col+2],[@row+3,@col+3]].select { |a| a.all? { |e| e >= 0 && e < 8 } }
        cross_check_1.map! { |i| @board[i[0]][i[1]] }
        cross_check_1 = clear_checking_arr(cross_check_1)
        if (cross_check_1.all? { |i| i == "b" } || cross_check_1.all? { |i| i == "y" }) && cross_check_1.length == 4
            @game_status = false
            p "We have a winner!!!"
            return true
        end
        cross_check_2 = [[@row-3,@col+3],[@row-2,@col+2],[@row-1,@col+1],[@row,@col],[@row+1,@col-1],[@row+2,@col-2],[@row+3,@col-3]].select { |a| a.all? { |e| e >= 0 && e < 8 } }
        cross_check_2.map! { |i| @board[i[0]][i[1]] }
        cross_check_2 = clear_checking_arr(cross_check_2)
        if (cross_check_2.all? { |i| i == "b" } || cross_check_2.all? { |i| i == "y" }) && cross_check_2.length == 4
            @game_status = false
            p "We have a winner!!!"
            return true
        end
    end
end

gaming = ConnectFour.new
gaming.game_on