//
//  NewsFeedViewController.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/1/20.
//  Copyright (c) 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    @IBOutlet weak var table: UITableView!
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(heandleRefreshControl), for: .valueChanged)
        return refreshControl
    }()
    
    private var feedViewModel = FeedViewModel(cells: [], footerTirle: nil)
    
    private let titleView = TitleView()
    lazy private var footerView = FooterView()
    
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        setupTable()
        setupTopBar()
        
        interactor?.makeRequest(request: .getFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(let feedViewModel):
            
            self.feedViewModel = feedViewModel
            table.reloadData()
            refreshControl.endRefreshing()
            footerView.setTitle(feedViewModel.footerTirle)
            
        case .displayUser(userViewModel: let userViewModel):
            
            titleView.set(viewModel: userViewModel)
            
        case .displayFoterLoader:
            footerView.showLoader()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: .getNextBatch)
        }
    }
    
    
    // MARK: - Objc methods
    
    @objc private func heandleRefreshControl() {
        interactor?.makeRequest(request: .getFeed)
    }
    
    
    // MARK: - Private properties
    
    private func setupTable() {
        table.contentInset.top = 8
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.addSubview(refreshControl)
        table.tableFooterView = footerView
        
    }
    
    private func setupTopBar() {
        self.navigationItem.titleView = titleView
    }
}


// MARK: - UITableViewDataSource
extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        let viewModel = feedViewModel.cells[indexPath.row]
        
        cell.cellDelegate = self
        cell.set(viewModel: viewModel)
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalHieght = feedViewModel.cells[indexPath.row].sizes.totalHieght
        return totalHieght
    }
    
    // We have dynamic cells -> should use estimated height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalHeight = feedViewModel.cells[indexPath.row].sizes.totalHieght
        return totalHeight
    }
}


// MARK: - NewsFeedCodeCellDelegate
extension NewsFeedViewController: NewsFeedCodeCellDelegate {
    func revealCell(for cell: NewsFeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let viewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: .revealWithPostIDs(id: viewModel.postId))
    }
}
