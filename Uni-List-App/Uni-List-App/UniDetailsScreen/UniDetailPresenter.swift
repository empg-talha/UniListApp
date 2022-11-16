//
//  UniDetailPresenter.swift
//  Uni-List-App
//
//  Created by Talha Ahmad on 16/11/2022.
//

import Foundation

protocol UniDetailProtocol: AnyObject {
    func getDetails() -> UniCellModel
}

class UniDetailPresenter: UniDetailProtocol {
    
    private var data: UniCellModel!
    
    init(data: UniCellModel){
        self.data = data
    }
    
    func getDetails() -> UniCellModel {
        return self.data
    }
    
    
}
