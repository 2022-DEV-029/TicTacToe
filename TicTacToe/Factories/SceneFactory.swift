//
//   SceneFactory.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import UIKit

protocol SceneFactory {
    var configurator: GameConfigurator! { get set }
    func makeGameScene() -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    var configurator: GameConfigurator!
    
    func makeGameScene() -> UIViewController {
        let vc = GameViewController()
        return configurator.configured(vc)
    }
}
