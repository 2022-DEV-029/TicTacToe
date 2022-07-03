//
//   GameInteractor.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation

typealias GameInteractorInput = GameViewControlerOutput

protocol GameInteractorOutput {
    func presentGameMove()
    func presentReset()
}

final class GameInteractor {
    var output: GameInteractorOutput?
    var worker: GameWorkerLogic?
}

extension GameInteractor: GameInteractorInput {
    func playAMove(positionIdentifer: Int) {
        worker?.play(positionIdentifer: positionIdentifer, handler: { gameInfo in
            output?.presentGameMove()
        })
    }
    
    func reset() {
        worker?.reset(handler: { gameInfo in
            output?.presentReset()
        })
    }
}


