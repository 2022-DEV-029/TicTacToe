//
//   GameInteractorTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import XCTest

class GameInteractorTests: XCTestCase {

    private var sut: GameInteractor!
    
    override func setUp() {
        super.setUp()
        
        sut = GameInteractor()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

}
