//
//   GameViewControllerTests.swift
//   TicTacToeTests
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

@testable import TicTacToe
import XCTest

final class GameViewControllerTests: XCTestCase {

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
    
    // MARK: UI Elements
    
    func test_givenScene_whenViewIsLoaded_thenShouldShowUIElements() {
        XCTAssertEqual(tileButtonsVisible(), true)
        XCTAssertEqual(resetButtonVisible(), true)
        XCTAssertEqual(infoLabelVisible(), true)
    }

}

private extension GameViewControllerTests {
    // MARK: UI Elements Check
    
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
