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
    let infoLabelText: String?
    let infoLabelBackground: UIColor?
    let tileText: String?
}

extension GameInfo: Equatable {}

enum Player {
    case playerX
    case playerO
}

enum GameStatusInfo {
    case start
}
