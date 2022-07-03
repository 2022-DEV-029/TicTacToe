//
//   GamePresenterTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import XCTest

final class GamePresenterTests: XCTestCase {

    // MARK: Subject under test
    
    private var sut: GamePresenter!
    private var viewController: GamePresenterOutputSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        viewController = GamePresenterOutputSpy()
        sut = GamePresenter()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalled_thenVCsProperMethodInvoked() {
        sut.presentGameMove(gameInfo: GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil))
        
        XCTAssertTrue(viewController.diplayGameMoveCalled.0)
    }
    
    func test_givenPresenter_whenResetCalled_thenVCsProperMethodInvoked() {
        sut.presentReset(gameInfo: GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil))
    
        XCTAssertTrue(viewController.resetCalled.0)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalled_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: 1, infoLabelText: "Player X Move", infoLabelBackground: .clear, tileText: "O")
        sut.presentGameMove(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.diplayGameMoveCalled.1, gameInfo)
    }
    
    func test_givenPresenter_whenResetCalled_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: "Player X Move", infoLabelBackground: .clear, tileText: nil)
        sut.presentReset(gameInfo: gameInfo)
    
        XCTAssertEqual(viewController.resetCalled.1, gameInfo)
    }

}

private final class GamePresenterOutputSpy: GamePresenterOutput {
    var diplayGameMoveCalled: (Bool, GameInfo)!
    var resetCalled: (Bool, GameInfo)!
    
    func displayGameMove(gameInfo: GameInfo) {
        diplayGameMoveCalled = (true, gameInfo)
    }
    func reset(gameInfo: GameInfo) {
        resetCalled = (true, gameInfo)
    }
}

