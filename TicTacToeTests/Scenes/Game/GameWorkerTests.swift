//
//   GameWorkerTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import XCTest

class GameWorkerTests: XCTestCase {

    // MARK: Subject under test
    
    private var sut: GameWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = GameWorker()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    

}
