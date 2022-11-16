//
//  UniDetailView.swift
//  Uni-List-App
//
//  Created by Talha Ahmad on 16/11/2022.
//

import Foundation
import UIKit

class UniDetailsView: UIViewController {
    
    lazy var titletLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        return stack
    }()
    
    var presenter: UniDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        
        view.backgroundColor = .white
        
        view.addSubview(verticalStack)
        NSLayoutConstraint(item: self.view!, attribute: .centerY, relatedBy: .equal, toItem: verticalStack, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .leading, relatedBy: .equal, toItem: verticalStack, attribute: .leading, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .trailing, relatedBy: .equal, toItem: verticalStack, attribute: .trailing, multiplier: 1, constant: 10).isActive = true
        
        verticalStack.addArrangedSubview(titletLabel)
        verticalStack.addArrangedSubview(subtitleLabel)
        
        titletLabel.text = presenter.getDetails().name
        subtitleLabel.text = presenter.getDetails().web_pages.first ?? ""
    }
    
}
