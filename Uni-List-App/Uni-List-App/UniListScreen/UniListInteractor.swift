//
//  UniListInteractor.swift
//  University-List
//
//  Created by Talha Ahmad on 15/11/2022.
//

import Foundation

protocol UniListInteractorProtocol: AnyObject {
    func fetchUniList()
}

class UnilistInteractor: UniListInteractorProtocol {
    
    private var networkManager: NetworkManagerProtocol!
    weak var presenter: UnitListInteractorPresenterProtocol!
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchUniList() {
        guard let url = URL(string: NetworkManager.UniAPI.list.endpoint) else {
            // show error
            return
        }
            
        networkManager.getData(url: url) { [weak self] (result: Result<[UniCellModel], UniAppNetworkError>) in
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let list):
                    self?.presenter.populate(list: list)
                    break
                case .failure(let error):
                    self?.presenter.errorReceived(error)
                    break
                }
            }
        }
    }
}
