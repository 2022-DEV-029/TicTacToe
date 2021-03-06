//
//   GameViewController.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import UIKit

typealias GameViewControlerInput = GamePresenterOutput

protocol GameViewControlerOutput: AnyObject {
    func playAMove(positionIdentifer: Int)
    func reset()
}

final class GameViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet private var tileButtons: [UIButton]!
    @IBOutlet private weak var infoLabel: UILabel!
    
    var interactor: GameInteractorInput?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.reset()
    }
    
    // MARK: Actions

    @IBAction func tileButtonTapped(_ sender: UIButton) {
        interactor?.playAMove(positionIdentifer: sender.tag)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        interactor?.reset()
    }
    
}

extension GameViewController: GameViewControlerInput {
    func displayGameMove(gameUI: GameUI) {
        guard let tileIdentifer = gameUI.tileIdentifer, let tileText = gameUI.tileText, let infoLabelText = gameUI.infoLabelText, let infoLabelBackground = gameUI.infoLabelBackground else {
            return
        }
        let tile = getButtonsFromList(tileIdentifer)
        tile.titleLabel?.textColor = .black
        tile.setTitleColor(.black, for: .normal)
        tile.setTitle(tileText, for: .normal)
        tile.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        infoLabel.text = infoLabelText
        infoLabel.backgroundColor = infoLabelBackground
    }
    
    func reset(gameUI: GameUI) {
        guard let infoLabelText = gameUI.infoLabelText, let infoLabelBackground = gameUI.infoLabelBackground else {
            return
        }
        
        tileButtons.forEach { tileButton in
            tileButton.backgroundColor = .white
            tileButton.setTitle("", for: .normal)
        }
        infoLabel.text = infoLabelText
        infoLabel.backgroundColor = infoLabelBackground
    }
    
    
}

private extension GameViewController {
    private func getButtonsFromList(_ identifier: Int) -> UIButton {
        return tileButtons.first(where: { $0.tag == identifier  })!
    }
}
