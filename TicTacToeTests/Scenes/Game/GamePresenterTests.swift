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
    private var output: GamePresenterOutputSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        output = GamePresenterOutputSpy()
        sut = GamePresenter()
        sut.output = output
    }
    
    override func tearDown() {
        sut = nil
        output = nil
        
        super.tearDown()
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalled_thenVCsProperMethodInvoked() {
        sut.presentGameMove(gameInfo: GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil))
        
        XCTAssertTrue(output.diplayGameMoveCalled.0)
    }
    
    func test_givenPresenter_whenResetCalled_thenVCsProperMethodInvoked() {
        sut.presentReset(gameInfo: GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil))
    
        XCTAssertTrue(output.resetCalled.0)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalled_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: 1, infoLabelText: "Player X Move", infoLabelBackground: .clear, tileText: "O")
        sut.presentGameMove(gameInfo: gameInfo)
        
        XCTAssertEqual(output.diplayGameMoveCalled.1, gameInfo)
    }
    
    func test_givenPresenter_whenResetCalled_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: "Player X Move", infoLabelBackground: .clear, tileText: nil)
        sut.presentReset(gameInfo: gameInfo)
    
        XCTAssertEqual(output.resetCalled.1, gameInfo)
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

