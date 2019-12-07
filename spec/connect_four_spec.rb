require "./lib/connect_four"


RSpec.describe ConnectFour do
    
    game = ConnectFour.new
    
    describe "#place_color" do
        it "should place a color without breaking rules." do
            row = game.board[-1]
            if row.all? { |r| r == " " }
                expect(game.place_color("b",3)).to eql(game.board[-1][3] == "b")
            elsif row[-1][3] != " " && row[-2][3] == " "
                expect(game.place_color("b",3)).to eql(game.board[-2][3] == "b")
            end
        end
    end

    describe "#connected_four?" do
        it "should return true if game won by any player." do
            r = 0
            while r < 5
                c = r
                expect(game.connected_four?).to eql(true) if game.board[r][c] == "b" && game.board[r+1][c+1] == "b" && game.board[r+2][c+2] == "b" && game.board[r+3][c+3] == "b"
                r += 1
            end
        end
    end

    describe "#game_status" do
        it "should check if program should be run or over and return correct boolean value." do
            if game.input == "q"
                expect(game.game_status).to eql(false)
            elsif game.connected_four?
                expect(game.game_status).to eql(false)
            end
        end
    end
end