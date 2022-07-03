//
//   GameInteractorTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import XCTest

class GameInteractorTests: XCTestCase {

    // MARK: Subject under test
    
    private var sut: GameInteractor!
    private var presenter: GamePresenterSpy!
    private var worker: GameWorkerSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = GameInteractor()
        presenter = GamePresenterSpy()
        worker = GameWorkerSpy()
        sut.presenter = presenter
        sut.worker = worker
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: Worker
    
    func test_givenInteractor_whenTryToPlay_thenWorkerCalled() {
        sut.playAMove(positionIdentifer: 1)
        
        XCTAssertTrue(worker.playCalled)
    }
    
    func test_givenInteractor_whenTryToReset_thenWorkerCalled() {
        sut.reset()
        
        XCTAssertTrue(worker.resetCalled)
    }
    
    // MARK: Test Output
    
    func test_givenInteractor_whenTryToPlay_AndWorkerReturnsValue_thenPresenterIsCalled() {
        let expectation = expectation(description: "Wait for worker play() to return")
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        worker.handlerMock = gameInfo
        sut.playAMove(positionIdentifer: 1)
        
        expectation.fulfill()
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.presentGameMoveCalled)
    }
    
    func test_givenInteractor_whenTryToReset_AndWorkerReturnsValue_thenPresenterIsCalled() {
        let expectation = expectation(description: "Wait for worker reset() to return")
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        worker.handlerMock = gameInfo
        sut.reset()
        
        expectation.fulfill()
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.presentResetCalled)
    }
    
    func test_givenInteractor_whenTryToPlay_andWorkerReturnsValue_thenDataIsPassedToOutput() {
        let expectation = expectation(description: "Wait for worker play() to return")
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        worker.handlerMock = gameInfo
        sut.playAMove(positionIdentifer: 1)
        
        expectation.fulfill()
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(presenter.gameInfoMock, gameInfo)
    }
    
    func test_givenInteractor_whenTryToReset_andWorkerReturnsValue_thenDataIsPassedToOutput() {
        let expectation = expectation(description: "Wait for worker reset() to return")
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        worker.handlerMock = gameInfo
        sut.reset()
        
        expectation.fulfill()
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(presenter.gameInfoMock, gameInfo)
    }

}

private final class GamePresenterSpy: GamePresenterInput {
    var gameInfoMock: GameInfo!
    
    var presentGameMoveCalled = false
    
    func presentGameMove(gameInfo: GameInfo) {
        presentGameMoveCalled = true
        gameInfoMock = gameInfo
    }
    
    var presentResetCalled = false
    
    func presentReset(gameInfo: GameInfo) {
        presentResetCalled = true
        gameInfoMock = gameInfo
    }
}

private final class GameWorkerSpy: GameWorkerLogic {
    var playCalled = false
    var resetCalled = false
    
    var handlerMock: GameInfo?
    
    func play(positionIdentifer: Int, handler: ((GameInfo)->Void)) {
        playCalled = true
        
        if let gameInfo = handlerMock {
            handler(gameInfo)
        }
    }
    
    func reset(handler: ((GameInfo)->Void)) {
        resetCalled = true
        
        if let gameInfo = handlerMock {
            handler(gameInfo)
        }
    }
}
