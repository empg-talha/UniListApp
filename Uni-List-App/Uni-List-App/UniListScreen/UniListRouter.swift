//
//  UniListRouter.swift
//  University-List
//
//  Created by Talha Ahmad on 15/11/2022.
//

import Foundation
import UIKit

protocol UniListRouterProtocol: AnyObject{
    static func start() -> UniListView
    func navigateToDetailScreen(with data: UniCellModel, from navVC: UINavigationController)
}

class UniListRouter: UniListRouterProtocol {
    
    static func start() -> UniListView {
        
        let view = UniListView()
        let interactor = UnilistInteractor()
        let presenter = UniListPresenter()
        let router = UniListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToDetailScreen(with data: UniCellModel,
                                from navVC: UINavigationController) {
        let view = UniDetailsView()
        let presenter = UniDetailPresenter(data: data)
        
        view.presenter = presenter
        navVC.pushViewController(view, animated: true)
    }
}
