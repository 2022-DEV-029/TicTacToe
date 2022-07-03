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
        guard let position = getPositionFromUITag(tagValue: positionIdentifer) else { return }
        
        // Get the row and column of the position
        let positionSplit = position.components(separatedBy: ".")
        guard let playedRow = Int(positionSplit[0]), let playedColumn = Int(positionSplit[1]) else { return }
        
        // Check if position already played.
        guard board[playedRow][playedColumn] == "" else {
            let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
            handler(gameInfo)
            return
        }
        
        // Add Player Move to the Board.
        addMoveToBoard(row: playedRow, column: playedColumn)
        
        let gameInfo = GameInfo(tileIdentifer: positionIdentifer, infoLabelText: "Player \(getNextPlayerName()) turn", infoLabelBackground: getInfoLabelBackgroundColor(status: status), tileText: getPlayerName())
        handler(gameInfo)
    }
    
    func reset(handler: ((GameInfo) -> Void)) {
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        handler(gameInfo)
    }
    
    
}

private extension GameWorker {
    // Game utilities
    
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
    
    private func getNextPlayerName() -> String {
        switch (currentPlayer) {
        case .playerX:
            return "O"
        case .playerO:
            return "X"
        }
    }
    
    private func getInfoLabelBackgroundColor(status: GameStatusInfo) -> UIColor {
        switch status {
        case .start:
            return .clear
        }
    }
}


