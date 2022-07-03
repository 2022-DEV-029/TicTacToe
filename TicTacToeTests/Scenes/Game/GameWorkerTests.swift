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
    
    // MARK: SUCCESS MOVES
    
    func test_givenWorker_whenPlayIsCalled_thenGameInfoIsReturned() {
        let gameInfoResult = playMoveOnSut(position: 1)
        
        waitForExpectations(timeout: 0.1)
        
        
        XCTAssertNotNil(gameInfoResult)
    }
    
    func test_givenWorker_whenPlayIsCalled_thenFirstMoveIsMarkedAndNextMoveIsReturned() {
        let gameInfoResult = playMoveOnSut(position: 1)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(gameInfoResult.tileIdentifer, 1)
        XCTAssertEqual(gameInfoResult.infoLabelText, "Player O turn")
        XCTAssertEqual(gameInfoResult.infoLabelBackground, .clear)
        XCTAssertEqual(gameInfoResult.tileText, "X")
    }
    
    func test_givenWorker_whenPlayIsCalled_WithWinForPlayerX_thenWinForPlayerXIsReturned() {
        let _ = playMoveOnSut(position: 0)
        let _ = playMoveOnSut(position: 3)
        let _ = playMoveOnSut(position: 1)
        let _ = playMoveOnSut(position: 5)
        let gameInfoResultFinalMove = playMoveOnSut(position: 2)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(gameInfoResultFinalMove.tileIdentifer, 2)
        XCTAssertEqual(gameInfoResultFinalMove.infoLabelText, "Player X has Won the Game!!")
        XCTAssertEqual(gameInfoResultFinalMove.infoLabelBackground, .green)
        XCTAssertEqual(gameInfoResultFinalMove.tileText, "X")
    }
    
    // MARK: RESET
    
    func test_givenWorker_whenResetIsCalled_thenGameInfoIsReturned() {
        let gameInfoResult = resetGameOnSut()
        
        waitForExpectations(timeout: 0.1)
        
        
        XCTAssertNotNil(gameInfoResult)
    }
    
    // MARK: INVALID MOVES
    
    func test_givenWorker_whenPlayIsCalled_OnAlreadyPlayedPosition_thenNothingIsReturned() {
        let _ = playMoveOnSut(position: 1)
        let gameInfoResult = playMoveOnSut(position: 1)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(gameInfoResult.tileIdentifer, nil)
        XCTAssertEqual(gameInfoResult.infoLabelText, nil)
        XCTAssertEqual(gameInfoResult.infoLabelBackground, nil)
        XCTAssertEqual(gameInfoResult.tileText, nil)
    }
    
    func test_givenWorker_whenPlayIsCalled_OnInvalidPosition_thenNothingIsReturned() {
        let gameInfoResult = playMoveOnSut(position: 10)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(gameInfoResult.tileIdentifer, nil)
        XCTAssertEqual(gameInfoResult.infoLabelText, nil)
        XCTAssertEqual(gameInfoResult.infoLabelBackground, nil)
        XCTAssertEqual(gameInfoResult.tileText, nil)
    }

}

private extension GameWorkerTests {
    func playMoveOnSut(position: Int) -> GameInfo {
        let expectation = expectation(description: "Wait for play() to return for move \(position)")
        var gameInfoResult: GameInfo!
        
        sut.play(positionIdentifer: position) { gameInfo in
            gameInfoResult = gameInfo
            expectation.fulfill()
        }
        return gameInfoResult
    }
    
    func resetGameOnSut() -> GameInfo {
        let expectation = expectation(description: "Wait for reset() to return")
        var gameInfoResult: GameInfo!
        
        sut.reset() { gameInfo in
            gameInfoResult = gameInfo
            expectation.fulfill()
        }
        return gameInfoResult
    }
    
}
