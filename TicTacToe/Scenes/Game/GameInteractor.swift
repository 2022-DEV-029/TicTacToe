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
}

final class GameInteractor {
    var output: GameInteractorOutput?
}

extension GameInteractor: GameInteractorInput {
    func playAMove(positionIdentifer: Int) {
        output?.presentGameMove()
    }
    
    func reset() {
        
    }
}


