//
//  LaunchesViewController.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var fetchSession: URLSessionDataTask?
    
    let disposeBag = DisposeBag()
    private var viewModel : LaunchListViewModel!
    
    static func instantiate(viewModel : LaunchListViewModel) -> LaunchesViewController {
        let storyboard = UIStoryboard.main
        let viewController = storyboard.instantiateViewController(withIdentifier: self.nameOfClass) as! LaunchesViewController
        viewController.viewModel = viewModel
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindView()
        fetchData()
    }
    
    func setupUI() {
        self.navigationItem.title = viewModel.title
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerXibs(identifiers: [LaunchListTableViewCell.nameOfClass])
    }
    
    func bindView() {
        
        tableView.rx.launchSelected.observe(on: MainScheduler.instance).subscribe(onNext: { indexPath in
            self.viewModel.launchSelected(at: indexPath)
        }).disposed(by: disposeBag)
    }
    
    func fetchData() {
        
        viewModel.fetchLaunchViewModel().observe(on: MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: LaunchListTableViewCell.nameOfClass, cellType: LaunchListTableViewCell.self)) { index, viewModel, cell in
            cell.item = viewModel
        }.disposed(by: disposeBag)
    }
}
