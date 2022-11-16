//
//  UniListPresenter.swift
//  University-List
//
//  Created by Talha Ahmad on 15/11/2022.
//

import Foundation
import UIKit

protocol UniListViewPresenterProtocol: AnyObject {
    func startFetchingData()
    func getRecentListData() -> [UniCellModel]
    func showDetailedScreen(for index: Int, from navVC: UINavigationController)
    func getTitle() -> String
}

protocol UnitListInteractorPresenterProtocol: AnyObject {
    func populate(list: [UniCellModel])
    func errorReceived(_ error: UniAppNetworkError)
}

class UniListPresenter: UniListViewPresenterProtocol {
    
    
    var list: [UniCellModel] = []
    weak var view: UniListViewProtocol?
    var interactor: UniListInteractorProtocol!
    var router: UniListRouterProtocol!
    
    func startFetchingData() {
        interactor.fetchUniList()
    }
    
    func getRecentListData() -> [UniCellModel] {
        return list
    }
    
    func showDetailedScreen(for index: Int,
                            from navVC: UINavigationController) {
        router.navigateToDetailScreen(with: list[index], from: navVC)
    }
    
    func getTitle() -> String {
        return "Universities List"
    }
    
}


extension UniListPresenter: UnitListInteractorPresenterProtocol {
    func populate(list: [UniCellModel]) {
        self.list = list
        view?.showUpdatedData()
    }
    
    func errorReceived(_ error: UniAppNetworkError) {
        view?.showError(error: error)
    }
    
    
}
