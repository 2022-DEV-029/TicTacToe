//
//   GamePresenter.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation

typealias GamePresenterInput = GameInteractorOutput

protocol GamePresenterOutput: AnyObject {
    func displayGameMove(gameInfo: GameInfo)
    func reset(gameInfo: GameInfo)
}

final class GamePresenter {
    weak var viewController: GamePresenterOutput?
}

extension GamePresenter: GamePresenterInput {
    func presentGameMove(gameInfo: GameInfo) {
        viewController?.displayGameMove(gameInfo: gameInfo)
    }
    
    func presentReset(gameInfo: GameInfo) {
        viewController?.reset(gameInfo: gameInfo)
    }
}

