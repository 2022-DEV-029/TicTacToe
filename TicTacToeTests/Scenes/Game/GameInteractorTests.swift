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
    private var output: GameInteractionOutputSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = GameInteractor()
        output = GameInteractionOutputSpy()
        sut.output = output
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: Test Output
    
    func test_givenInteractor_whenTryToPlay_thenPresenterIsCalled() {
        sut.playAMove(positionIdentifer: 1)
        
        XCTAssertTrue(output.presentGameMoveCalled)
    }
    
    func test_givenInteractor_whenTryToReset_thenPresenterIsCalled() {
        sut.reset()
        
        XCTAssertTrue(output.presentResetCalled)
    }

}

private final class GameInteractionOutputSpy: GameInteractorOutput {
    var presentGameMoveCalled = false
    
    func presentGameMove() {
        presentGameMoveCalled = true
    }
    
    var presentResetCalled = false
    
    func presentReset() {
        presentResetCalled = true
    }
}

