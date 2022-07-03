//
//   GameViewControllerTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

@testable import TicTacToe
import XCTest

class GameViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    
    var sut: GameViewController!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
      super.setUp()
        
      setupGameViewController()
    }
    
    override func tearDown() {
      sut = nil
      
      super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupGameViewController() {
        sut = GameViewController()
        sut.loadView()
    }
    
    // MARK: View Loaded
    
    func test_givenScene_whenViewIsLoaded_thenloadViewIsCalled() {
        XCTAssertTrue(sut.isViewLoaded)
    }

}
