import numpy as np
import copy


class AIplayer:
    def __init__(self, board, my_mark, opponent_mark):
        self.board = board


class MinMaxPlay(AIplayer):
    def __init__(self, board, my_mark, opponent_mark):
        super(MinMaxPlay, self).__init__(board, my_mark, opponent_mark)
        self.my_mark = my_mark
        self.opponent_mark = opponent_mark

    def searchEmptyPlaces(self, board):
        empty_places = []
        for row in range(3):
            for col in range(3):
                if board.checkEmpty(row, col):
                    empty_places.append((row, col))
        return empty_places

    def minmax(self, board, my_turn, depth):
        scores = {}
        empty_places = self.searchEmptyPlaces(board)
        for place in empty_places:
            row, col = place[0], place[1]
            virt_board = copy.deepcopy(board)
            if my_turn:
                virt_board.setMark(row, col, self.my_mark)
            else:
                virt_board.setMark(row, col, self.opponent_mark)
            score = self.score(virt_board, my_turn, depth)
            if score is not None:
                scores[(row, col)] = score
            else:
                score = self.minmax(virt_board, not my_turn, depth + 1)[0]
                scores[(row, col)] = score
        # print "scores:", scores # debug print
        if my_turn:
            return (max(scores.values()), max(scores, key=(lambda x: scores[x])))
        else:
            return (min(scores.values()), min(scores, key=(lambda x: scores[x])))

    def getInput(self):
        board = copy.deepcopy(self.board)  # virtual board
        ret = self.minmax(board, True, 0)
        print()
        return ret[1]

    def score(self, board, my_turn, depth):
        goal_flg = board.checkGoal()
        if goal_flg == 1:
            if my_turn:
                return 10 - depth
            else:  # opponent wins
                return depth - 10
        elif goal_flg == -1:  # draw
            return 0  # un-finished case
        else:
            return None


class Board:
    def __init__(self, initial_turn=True):
        self.spaces = np.array([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
        self.cnt_mark = 0

    def reset(self):
        self.spaces = np.array([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
        self.cnt_mark = 0

    def checkEmpty(self, row, col):
        if self.spaces[row][col] == " ":
            return True
        else:
            return False

    def checkInput(self, row, col):
        if (not row in [0, 1, 2]) or (not col in [0, 1, 2]):
            return (False, "incorrect input, over/under range.")
        elif not self.checkEmpty(row, col):
            return (False, "incorrect input, it have been placed.")
        else:
            return (True, "")

    def setMark(self, row, col, mark):
        self.spaces[row][col] = mark
        self.cnt_mark += 1

    # 0: not finish, 1:finish, a user win -1: draw
    def checkGoal(self):
        if self.checkGoalOnRow() or self.checkGoalOnColumn() or \
                self.checkGoalOnDiagonal():
            return 1
        elif self.cnt_mark == 9:
            return -1
        else:
            return 0

    def checkGoalOnRow(self):
        for row in range(3):
            if not self.spaces[row][0] == " " and \
                                    self.spaces[row][0] == self.spaces[row][1] == self.spaces[row][2]:
                return True
        return False

    def checkGoalOnColumn(self):
        for col in range(3):
            if not self.spaces[0][col] == " " and \
                                    self.spaces[0][col] == self.spaces[1][col] == self.spaces[2][col]:
                return True
        return False

    def checkGoalOnDiagonal(self):
        if not self.spaces[1][1] == " ":
            if self.spaces[0][0] == self.spaces[1][1] == self.spaces[2][2]:
                return True
            if self.spaces[0][2] == self.spaces[1][1] == self.spaces[2][0]:
                return True
        return False

    # CUI
    def dump(self):
        print("-------------")
        for row in range(3):
            print('|', end='')
            for col in range(3):
                print(self.spaces[row][col], end='|',)
            print("\n-------------")

class TicTacToe:
    def __init__(self, initial_turn=True):
        self.board = Board()
        self.board.reset()
        self.initial_turn = initial_turn
        self.player_mark, self.ai_mark = None, None
        self.ai = None

    def setAI(self, mode, my_mark, opponent_mark):
        if mode == 'minmax':
            self.ai = MinMaxPlay(self.board, my_mark, opponent_mark)
        else:
            print("Unknown ai mode is input.")
            exit()
        self.ai_mark = my_mark

    def setPlayerMark(self, mark):
        self.player_mark = mark

    def resetBoard(self):
        self.board.reset()

    def getInputFromStdin(self):
        print("It's your turn, please input the next position. ie 0 0.")
        while True:
            user_input = input().split()
            if len(user_input) != 2:
                print("incorrect input, incorrect input size.")
                continue
            elif not user_input[0].isdigit() or not user_input[1].isdigit():
                print("incorrect input, not integer input.")
                continue

            row, col = map(int, user_input)
            ret = self.board.checkInput(row, col)
            if ret[0]:
                return row, col
            else:
                print(ret[1])
                continue

    def play(self):
        player_turn = self.initial_turn  # if true: player, false: ai
        while True:
            if player_turn:
                row, col = self.getInputFromStdin()
                self.board.setMark(row, col, self.player_mark)
            else:  # ai turn
                row, col = self.ai.getInput()
                print(row, col, "is input.")
                self.board.setMark(row, col, self.ai_mark)
            self.board.dump()
            flg = self.board.checkGoal()
            if flg == 1:  # one of the player win
                if player_turn:
                    print("You win")
                else:
                    print("You loose")
                break
            elif flg == -1:
                print("Draw")
                break
            player_turn = not player_turn

if __name__ == '__main__':
    game = TicTacToe(True)
    game.setPlayerMark('o')
    game.setAI("minmax", 'x', 'o')
    game.play()