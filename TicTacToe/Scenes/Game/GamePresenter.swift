//
//   GamePresenter.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation
import UIKit

typealias GamePresenterInput = GameInteractorOutput

protocol GamePresenterOutput: AnyObject {
    func displayGameMove(gameUI: GameUI)
    func reset(gameUI: GameUI)
}

final class GamePresenter {
    weak var viewController: GamePresenterOutput?
}

extension GamePresenter: GamePresenterInput {
    func presentGameMove(gameInfo: GameInfo) {
        let gameUI = buildGameUI(from: gameInfo)
        viewController?.displayGameMove(gameUI: gameUI)
    }
    
    func presentReset(gameInfo: GameInfo) {
        let gameUI = buildGameUI(from: gameInfo)
        viewController?.reset(gameUI: gameUI)
    }
}

private extension GamePresenter {
    private func buildGameUI(from gameInfo: GameInfo) -> GameUI {
        let tileIdentifer = gameInfo.tileIdentifer
        let infoLabelText = getInfoLabelText(status: gameInfo.status, currentPlayer: gameInfo.currentPlayer)
        let infoLabelBackground = getInfoLabelBackgroundColor(status: gameInfo.status)
        let tileText = getTileText(status: gameInfo.status, currentPlayer: gameInfo.currentPlayer)
        return GameUI(tileIdentifer: tileIdentifer, infoLabelText: infoLabelText, infoLabelBackground: infoLabelBackground, tileText: tileText)
    }
}

private extension GamePresenter {
    private func getTileText(status: GameStatusInfo, currentPlayer: Player) -> String? {
        if status == .start || status == .invalidMove {
            return nil
        } else {
            return getPlayerName(currentPlayer: currentPlayer)
        }
    }
    
    private func getNextPlayerName(currentPlayer: Player) -> String {
        switch currentPlayer {
        case .playerX:
            return "O"
        case .playerO:
            return "X"
        }
    }
    
    private func getPlayerName(currentPlayer: Player) -> String {
        switch currentPlayer {
        case .playerX:
            return "X"
        case .playerO:
            return "O"
        }
    }
    
    private func getInfoLabelText(status: GameStatusInfo, currentPlayer: Player) -> String? {
        switch status {
        case .start:
            return "Player X turn"
        case .ongoing:
            return "Player \(getNextPlayerName(currentPlayer: currentPlayer)) turn"
        case .won:
            return "Player \(getPlayerName(currentPlayer: currentPlayer)) has Won the Game!!"
        case .draw:
            return "It's a Draw!!"
        case .invalidMove:
            return nil
        }
    }
    
    private func getInfoLabelBackgroundColor(status: GameStatusInfo) -> UIColor? {
        switch status {
        case .start:
            return .clear
        case .ongoing:
            return .clear
        case .won:
            return .green
        case .draw:
            return .yellow
        case .invalidMove:
            return nil
        }
    }
}
