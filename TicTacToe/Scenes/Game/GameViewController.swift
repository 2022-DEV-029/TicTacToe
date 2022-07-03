//
//   GameViewController.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import UIKit

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

    }
    
    // MARK: Actions

    @IBAction func tileButtonTapped(_ sender: UIButton) {
        interactor?.playAMove(positionIdentifer: sender.tag)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        interactor?.reset()
    }
    
}
