//
//   GameWorker.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation
import UIKit

protocol GameWorkerLogic {
    func play(positionIdentifer: Int, handler: ((GameInfo)->Void))
    func reset(handler: ((GameInfo)->Void))
}

final class GameWorker {
    private var currentPlayer: Player
    private var status: GameStatusInfo
    private var board : [[String]] = [["","",""],["","",""],["","",""]]
    
    init() {
        currentPlayer = .playerX
        status = .start
    }
}

extension GameWorker: GameWorkerLogic {
    func play(positionIdentifer: Int, handler: ((GameInfo) -> Void)) {
        // Get the position played
        guard let position = getPositionFromUITag(tagValue: positionIdentifer) else {
            let gameInfo = getGameInfoForInvalidMoves()
            handler(gameInfo)
            return
        }
        
        // Get the row and column of the position
        let positionSplit = position.components(separatedBy: ".")
        guard let playedRow = Int(positionSplit[0]), let playedColumn = Int(positionSplit[1]) else {
            let gameInfo = getGameInfoForInvalidMoves()
            handler(gameInfo)
            return
        }
        
        // Check if position already played.
        guard board[playedRow][playedColumn] == "" else {
            let gameInfo = getGameInfoForInvalidMoves()
            handler(gameInfo)
            return
        }
        
        // Add Player Move to the Board.
        addMoveToBoard(row: playedRow, column: playedColumn)
        
        // Check for win
        let DidPlayerWin = checkResult(row: playedRow, column: playedColumn)
        
        if DidPlayerWin {
            // Win case
            status = .won
            let gameInfo = getGameInfo(tileIdentifer: positionIdentifer)
            handler(gameInfo)
        }  else {
            // Game still ongoing case
            status = .ongoing
            let gameInfo = getGameInfo(tileIdentifer: positionIdentifer)
            handler(gameInfo)
            toggleCurrentPlayer()
        }
    }
    
    func reset(handler: ((GameInfo) -> Void)) {
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        handler(gameInfo)
    }
    
    
}

private extension GameWorker {
    private func checkResult(row: Int, column: Int) -> Bool {
        // Row check
        let playedRow = board[row]
        let playedRowResult = playedRow.allSatisfy({ $0 == playedRow.first })
        
        // Column check
        let playedColumn = board.map { eachRow in
            return eachRow[column]
        }
        let playedColumnResult = playedColumn.allSatisfy({ $0 == playedColumn.first })
        
        // Diagonal check
        var playedDiagonalCheck = false
        if row == column {
            var diagonalItems: [String] = []
            for value in 0...2 {
                diagonalItems.append(board[value][value])
            }
            playedDiagonalCheck = diagonalItems.allSatisfy({ $0 == diagonalItems.first })
        }
        
        // Anti-Diagonal check
        var playedAntiDiagonalCheck = false
        if row + column == 2 {
            var antiDiagonalItems: [String] = []
            for i in (0...2).reversed() {
                antiDiagonalItems.append(board[i][2-i])
            }
            
            playedAntiDiagonalCheck = antiDiagonalItems.allSatisfy({ $0 == antiDiagonalItems.first })
        }
        
        return playedRowResult || playedColumnResult || playedDiagonalCheck || playedAntiDiagonalCheck
    }
}

private extension GameWorker {
    // Game utilities
    
    private func toggleCurrentPlayer() {
        currentPlayer = currentPlayer == .playerX ? .playerO : .playerX
    }
    
    private func addMoveToBoard(row: Int, column: Int) {
        board[row][column] = getPlayerName();
    }
    
    private func getPlayerName() -> String {
        switch (currentPlayer) {
        case .playerX:
            return "X"
        case .playerO:
            return "O"
        }
    }
}


private extension GameWorker {
    private func getPositionFromUITag(tagValue: Int) -> String? {
        switch tagValue {
        case 0:
            return "0.0"
        case 1:
            return "0.1"
        case 2:
            return "0.2"
        case 3:
            return "1.0"
        case 4:
            return "1.1"
        case 5:
            return "1.2"
        case 6:
            return "2.0"
        case 7:
            return "2.1"
        case 8:
            return "2.2"
        default:
            return nil
        }
    }
}

private extension GameWorker {
    
    private func getGameInfoForInvalidMoves() -> GameInfo {
        return GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
    }
    
    private func getGameInfo(tileIdentifer: Int?, forReset: Bool = false) -> GameInfo {
        return GameInfo(tileIdentifer: tileIdentifer, infoLabelText: getInfoLabelText(status: status), infoLabelBackground: getInfoLabelBackgroundColor(status: status), tileText: forReset ? nil : getPlayerName())
    }
    
    private func getNextPlayerName() -> String {
        switch (currentPlayer) {
        case .playerX:
            return "O"
        case .playerO:
            return "X"
        }
    }
    
    private func getInfoLabelText(status: GameStatusInfo) -> String {
        switch status {
        case .won:
            return "Player \(getPlayerName()) has Won the Game!!"
        case .start:
            return "Player X turn"
        case .ongoing:
            return "Player \(getNextPlayerName()) turn"
        }
    }
    
    private func getInfoLabelBackgroundColor(status: GameStatusInfo) -> UIColor {
        switch status {
        case .won:
            return .green
        case .start:
            return .clear
        case .ongoing:
            return .clear
        }
    }
}


