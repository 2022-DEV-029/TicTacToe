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
    weak var output: GamePresenterOutput?
}

extension GamePresenter: GamePresenterInput {
    func presentGameMove(gameInfo: GameInfo) {
        output?.displayGameMove(gameInfo: gameInfo)
    }
    
    func presentReset(gameInfo: GameInfo) {
        output?.reset(gameInfo: gameInfo)
    }
}

