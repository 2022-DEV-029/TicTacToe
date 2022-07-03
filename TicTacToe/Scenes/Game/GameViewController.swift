//
//   GameViewController.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import UIKit

protocol GameViewControlerOutput: AnyObject {
    func playAMove(positionIdentifer: Int)
}

final class GameViewController: UIViewController {

    @IBOutlet private var tileButtons: [UIButton]!
    @IBOutlet private weak var infoLabel: UILabel!
    
    var output: GameViewControlerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func tileButtonTapped(_ sender: UIButton) {
        output?.playAMove(positionIdentifer: sender.tag)
    }
    

}
