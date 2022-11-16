//
//  UniListView.swift
//  University-List
//
//  Created by Talha Ahmad on 15/11/2022.
//

import UIKit

protocol UniListViewProtocol: AnyObject {
    func showUpdatedData()
    func showError(error: UniAppNetworkError)
}

class UniListView: UIViewController {
    
    var presenter: UniListViewPresenterProtocol!
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = .black
        loader.hidesWhenStopped = true
        loader.stopAnimating()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.startFetchingData()
        loader.startAnimating()
    }
    
    func setupView() {
        view.backgroundColor = .green
        self.title = presenter.getTitle()
        self.view.addSubview(tableview)
        
        NSLayoutConstraint(item: self.view!, attribute: .top, relatedBy: .equal, toItem: tableview, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .leading, relatedBy: .equal, toItem: tableview, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .trailing, relatedBy: .equal, toItem: tableview, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .bottom, relatedBy: .equal, toItem: tableview, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        self.view.addSubview(errorLabel)
        NSLayoutConstraint(item: self.view!, attribute: .centerX, relatedBy: .equal, toItem: self.errorLabel, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .centerY, relatedBy: .equal, toItem: self.errorLabel, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        errorLabel.isHidden = true
        
        self.view.addSubview(loader)
        NSLayoutConstraint(item: self.view!, attribute: .centerX, relatedBy: .equal, toItem: loader, attribute: .centerX, multiplier: 1, constant: 0 ).isActive  = true
        NSLayoutConstraint(item: self.view!, attribute: .centerY, relatedBy: .equal, toItem: loader, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }

}

extension UniListView: UniListViewProtocol {
    func showUpdatedData() {
        tableview.isHidden = false
        errorLabel.isHidden = true
        tableview.reloadData()
        loader.stopAnimating()
    }
    
    func showError(error: UniAppNetworkError) {
        tableview.isHidden = true
        errorLabel.isHidden = false
        errorLabel.text = "Error Occured"
        loader.stopAnimating()
    }
}

extension UniListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getRecentListData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell")!
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = presenter.getRecentListData()[indexPath.row].name
        cellConfig.secondaryText = presenter.getRecentListData()[indexPath.row].web_pages.first ?? "no link"
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetailedScreen(for: indexPath.row, from: self.navigationController!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
