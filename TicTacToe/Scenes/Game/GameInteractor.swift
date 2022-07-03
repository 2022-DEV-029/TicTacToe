//
//   GameInteractor.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation

typealias GameInteractorInput = GameViewControlerOutput

protocol GameInteractorOutput {
    func presentGameMove(gameInfo: GameInfo)
    func presentReset(gameInfo: GameInfo)
}

final class GameInteractor {
    var output: GameInteractorOutput?
    var worker: GameWorkerLogic?
}

extension GameInteractor: GameInteractorInput {
    func playAMove(positionIdentifer: Int) {
        worker?.play(positionIdentifer: positionIdentifer, handler: { gameInfo in
            output?.presentGameMove(gameInfo: gameInfo)
        })
    }
    
    func reset() {
        worker?.reset(handler: { gameInfo in
            output?.presentReset(gameInfo: gameInfo)
        })
    }
}

