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
        self.navigationItem.title = viewModel.title
        
        setupUI()
        bindView()
        fetchData()
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerXibs(identifiers: [LaunchListTableViewCell.nameOfClass])
    }
    
    func bindView() {
        tableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
            if let rocketId = self?.viewModel.rocketId(at: indexPath.row) {
                let rocketViewModel = RocketDetailsViewModel(rocketId: rocketId)
                let rocketsViewController = RocketsViewController.instantiate(viewModel: rocketViewModel)
                self?.navigationController?.pushViewController(rocketsViewController, animated: true)
            }
          }).disposed(by: disposeBag)
    }
    
    func fetchData() {
        
        viewModel.fetchLaunchViewModel().observe(on: MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: LaunchListTableViewCell.nameOfClass, cellType: LaunchListTableViewCell.self)) { index, viewModel, cell in
            cell.item = viewModel
        }.disposed(by: disposeBag)
    }
}
