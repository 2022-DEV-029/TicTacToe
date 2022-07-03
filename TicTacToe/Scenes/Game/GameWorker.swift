//
//   GameWorker.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation

protocol GameWorkerLogic {
    func play(positionIdentifer: Int, handler: ((GameInfo)->Void))
    func reset(handler: ((GameInfo)->Void))
}

final class GameWorker {
    
}

extension GameWorker: GameWorkerLogic {
    func play(positionIdentifer: Int, handler: ((GameInfo) -> Void)) {
        
    }
    
    func reset(handler: ((GameInfo) -> Void)) {
        
    }
    
    
}
