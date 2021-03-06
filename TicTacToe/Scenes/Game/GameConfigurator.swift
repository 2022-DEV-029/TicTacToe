//
//   GameConfigurator.swift
//   TicTacToe
//   
//   Created by 2022-DEV-029 on 03/07/2022
//

import Foundation

protocol GameConfigurator {
    func configured(_ vc: GameViewController) -> GameViewController
}

final class DefaultGameConfigurator: GameConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: GameViewController) -> GameViewController {
        sceneFactory.configurator = self
        let worker = GameWorker()
        let interactor = GameInteractor()
        let presenter = GamePresenter()
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.interactor = interactor
        return vc
    }
}

