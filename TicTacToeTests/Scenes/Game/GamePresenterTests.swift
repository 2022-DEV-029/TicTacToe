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
        let gameInfo = GameInfo(tileIdentifer: nil, status: .start, currentPlayer: .playerX)
        sut.presentGameMove(gameInfo: gameInfo)
        
        XCTAssertTrue(viewController.diplayGameMoveCalled.0)
    }
    
    func test_givenPresenter_whenResetCalled_thenVCsProperMethodInvoked() {
        let gameInfo = GameInfo(tileIdentifer: nil, status: .start, currentPlayer: .playerX)
        sut.presentReset(gameInfo: gameInfo)
    
        XCTAssertTrue(viewController.resetCalled.0)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalledWithStart_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: nil, status: .start, currentPlayer: .playerX)
        sut.presentGameMove(gameInfo: gameInfo)
        
        let gameUI = getGameUIFromGameInfoForStart(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.diplayGameMoveCalled.1, gameUI)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalledWithOngoing_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: 1, status: .ongoing, currentPlayer: .playerO)
        sut.presentGameMove(gameInfo: gameInfo)
        
        let gameUI = getGameUIFromGameInfoForOngoing(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.diplayGameMoveCalled.1, gameUI)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalledWithWin_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: 1, status: .won, currentPlayer: .playerX)
        sut.presentGameMove(gameInfo: gameInfo)
        
        let gameUI = getGameUIFromGameInfoForWin(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.diplayGameMoveCalled.1, gameUI)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalledWithDraw_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: nil, status: .draw, currentPlayer: .playerX)
        sut.presentGameMove(gameInfo: gameInfo)
        
        let gameUI = getGameUIFromGameInfoForDraw(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.diplayGameMoveCalled.1, gameUI)
    }
    
    func test_givenPresenter_whenDiplayGameMoveCalledWithInvalid_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: nil, status: .invalidMove, currentPlayer: .playerO)
        sut.presentGameMove(gameInfo: gameInfo)
        
        let gameUI = getGameUIFromGameInfoForInvalid(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.diplayGameMoveCalled.1, gameUI)
    }
    
    func test_givenPresenter_whenResetCalled_thenVCsProperArgumentsPassed() {
        let gameInfo = GameInfo(tileIdentifer: nil, status: .start, currentPlayer: .playerX)
        sut.presentReset(gameInfo: gameInfo)
    
        let gameUI = getGameUIFromGameInfoForStart(gameInfo: gameInfo)
        
        XCTAssertEqual(viewController.resetCalled.1, gameUI)
    }

}

private extension GamePresenterTests {
    func getGameUIFromGameInfoForStart(gameInfo: GameInfo) -> GameUI {
        return GameUI(tileIdentifer: gameInfo.tileIdentifer, infoLabelText: "Player X turn", infoLabelBackground: .clear, tileText: nil)
    }
    
    func getGameUIFromGameInfoForOngoing(gameInfo: GameInfo) -> GameUI {
        return GameUI(tileIdentifer: gameInfo.tileIdentifer, infoLabelText: "Player X turn", infoLabelBackground: .clear, tileText: "O")
    }
    
    func getGameUIFromGameInfoForWin(gameInfo: GameInfo) -> GameUI {
        return GameUI(tileIdentifer: gameInfo.tileIdentifer, infoLabelText: "Player X has Won the Game!!", infoLabelBackground: .green, tileText: "X")
    }
    
    func getGameUIFromGameInfoForDraw(gameInfo: GameInfo) -> GameUI {
        return GameUI(tileIdentifer: gameInfo.tileIdentifer, infoLabelText: "It's a Draw!!", infoLabelBackground: .yellow, tileText: "X")
    }
    
    func getGameUIFromGameInfoForInvalid(gameInfo: GameInfo) -> GameUI {
        return GameUI(tileIdentifer: gameInfo.tileIdentifer, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
    }
}

private final class GamePresenterOutputSpy: GamePresenterOutput {
    var diplayGameMoveCalled: (Bool, GameUI)!
    var resetCalled: (Bool, GameUI)!
    
    func displayGameMove(gameUI: GameUI) {
        diplayGameMoveCalled = (true, gameUI)
    }
    func reset(gameUI: GameUI) {
        resetCalled = (true, gameUI)
    }
}

