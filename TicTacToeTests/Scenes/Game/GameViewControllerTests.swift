//
//   GameViewControllerTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

@testable import TicTacToe
import XCTest

final class GameViewControllerTests: XCTestCase {

    // MARK: Subject under test
    
    var sut: GameViewController!
    private var interactor: GameInteractorSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
      super.setUp()
        
      setupGameViewController()
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
      
      super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupGameViewController() {
        sut = GameViewController()
        interactor = GameInteractorSpy()
        sut.interactor = interactor
        sut.loadView()
    }
    
    // MARK: View Loaded
    
    func test_givenScene_whenViewIsLoaded_thenloadViewIsCalled() {
        XCTAssertTrue(sut.isViewLoaded)
    }
    
    func test_givenScene_whenViewDidLoad_thenResetIsCalled() {
        sut.viewDidLoad()
        XCTAssertTrue(interactor.resetCalled)
    }
    
    // MARK: UI Elements
    
    func test_givenScene_whenViewIsLoaded_thenShouldShowUIElements() {
        XCTAssertEqual(tileButtonsVisible(), true)
        XCTAssertEqual(resetButtonVisible(), true)
        XCTAssertEqual(infoLabelVisible(), true)
    }
    
    // MARK: UI Interaction
    
    func test_givenScene_whenATileButtonIsTapped_thenInteractorIsCalled() {
        tapTileButton(1)
        XCTAssertTrue(interactor.playAMoveCalled)
    }
    
    func test_givenScene_whenReseetButtonIsTapped_thenInteractorIsCalled() {
        tapResetButton()
        XCTAssertTrue(interactor.resetCalled)
    }
    
    // MARK: Output UI Success
    
    func test_givenScene_whenDisplayGameMoveIsCalled_thenUIUpdates() {
        let gameInfo = GameInfo(tileIdentifer: 1, infoLabelText: "Player O Move", infoLabelBackground: .clear, tileText: "X")
        sut.displayGameMove(gameInfo: gameInfo)
        
        let labelText = getInfoLabelTextAndBackground().0
        let labelBackgroundColor = getInfoLabelTextAndBackground().1
        
        XCTAssertEqual(labelText, "Player O Move")
        XCTAssertEqual(labelBackgroundColor, .clear)
    }
    
    func test_givenScene_wheResetIsCalled_thenUIUpdates() {
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: "Player X Move", infoLabelBackground: .clear, tileText: nil)
        sut.reset(gameInfo: gameInfo)
        
        let labelText = getInfoLabelTextAndBackground().0
        let labelBackgroundColor = getInfoLabelTextAndBackground().1
        
        XCTAssertEqual(labelText, "Player X Move")
        XCTAssertEqual(labelBackgroundColor, .clear)
    }
    
    // MARK: Output UI for Failure
    
    func test_givenScene_whenDisplayGameMoveIsCalledWithNilValue_thenNotUIUpdates() {
        let gameInfo = GameInfo(tileIdentifer: 1, infoLabelText: "Player O Move", infoLabelBackground: .clear, tileText: "X")
        sut.displayGameMove(gameInfo: gameInfo)
        
        let gameInfoInvalid = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        sut.displayGameMove(gameInfo: gameInfoInvalid)
        
        let labelText = getInfoLabelTextAndBackground().0
        let labelBackgroundColor = getInfoLabelTextAndBackground().1
        
        XCTAssertEqual(labelText, "Player O Move")
        XCTAssertEqual(labelBackgroundColor, .clear)
    }
    
    func test_givenScene_wheResetIsCalledWithNilValue_thenNotUIUpdates() {
        let gameInfo = GameInfo(tileIdentifer: nil, infoLabelText: "Player X Move", infoLabelBackground: .clear, tileText: nil)
        sut.reset(gameInfo: gameInfo)
        
        let gameInfoInvalid = GameInfo(tileIdentifer: nil, infoLabelText: nil, infoLabelBackground: nil, tileText: nil)
        sut.reset(gameInfo: gameInfoInvalid)
        
        let labelText = getInfoLabelTextAndBackground().0
        let labelBackgroundColor = getInfoLabelTextAndBackground().1
        
        XCTAssertEqual(labelText, "Player X Move")
        XCTAssertEqual(labelBackgroundColor, .clear)
    }

}

private final class GameInteractorSpy: GameInteractorInput {
    var playAMoveCalled = false
    
    func playAMove(positionIdentifer: Int) {
        playAMoveCalled = true
    }
    
    var resetCalled = false
    
    func reset() {
        resetCalled = true
    }
}

private extension GameViewControllerTests {
    // UI Elements Action
    
    func tapTileButton(_ tag: Int) {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    for subsubview in subview.subviews {
                        if let stackView = subsubview as? UIStackView {
                            for subStackView in stackView.subviews {
                                if let horizontalStackView = subStackView as? UIStackView {
                                    for button in horizontalStackView.subviews {
                                        if let tileButton = button as? UIButton, tileButton.tag == tag {
                                            tileButton.sendActions(for: .touchUpInside)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tapResetButton() {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    if let button = subview as? UIButton, button.titleLabel?.text == "Reset" {
                        button.sendActions(for: .touchUpInside)
                    }
                }
            }
        }
    }
    
    func getInfoLabelTextAndBackground() -> (String, UIColor) {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    if let label = subview as? UILabel {
                        return (label.text ?? "", label.backgroundColor ?? .brown)
                    }
                }
            }
        }
        return ("", .brown);
    }
}


private extension GameViewControllerTests {
    // UI Elements Check
    
    func tileButtonsVisible() -> Bool {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    for subsubview in subview.subviews {
                        if let stackView = subsubview as? UIStackView {
                            for subStackView in stackView.subviews {
                                if let horizontalStackView = subStackView as? UIStackView {
                                    for button in horizontalStackView.subviews {
                                        if let _ = button as? UIButton {
                                            return true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return false
    }
    
    func resetButtonVisible() -> Bool {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    if let button = subview as? UIButton, button.titleLabel?.text == "Reset" {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func infoLabelVisible() -> Bool {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    if let _ = subview as? UILabel {
                        return true
                    }
                }
            }
        }
        return false;
    }
}
