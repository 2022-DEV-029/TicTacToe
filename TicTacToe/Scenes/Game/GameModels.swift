//
//   GameModels.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation
import UIKit

struct GameInfo {
    let tileIdentifer: Int?
    let status: GameStatusInfo
    let currentPlayer: Player
}

extension GameInfo: Equatable {}

enum Player {
    case playerX
    case playerO
}

enum GameStatusInfo {
    case start
    case ongoing
    case won
    case draw
    case invalidMove
}

struct GameUI {
    let tileIdentifer: Int?
    let infoLabelText: String?
    let infoLabelBackground: UIColor?
    let tileText: String?
}

extension GameUI: Equatable {}
