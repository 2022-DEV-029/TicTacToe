//
//   GamePresenterTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import XCTest

class GamePresenterTests: XCTestCase {

    // MARK: Subject under test
    
    private var sut: GamePresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = GamePresenter()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

}
