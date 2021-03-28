//
//  LaunchesViewController.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import UIKit

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    class var classIdentifier: String {
        return String(format: "%@", self.nameOfClass)
    }
}

extension UITableView {
    func registerXibs(identifiers : [String]) {
        identifiers.forEach { (identifier) in
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}

class LaunchesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var launches: [Launch] = []
    private var fetchSession: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Launches"
        
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerXibs(identifiers: [LaunchListTableViewCell.nameOfClass])
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchData() {
        let service = LaunchesServiceRequests()
        self.showProgressView()
        service.getAllLaunches { [weak self] apiResult in
            DispatchQueue.main.async {
                self?.hideProgressView()
                switch apiResult {
                case .success(let launchList):
                    let allLaunches = launchList
                    let filtedLaunchhes = allLaunches.filter({ (launch) -> Bool in
                        
                        // Filter only last 3 years data
                        let currentYear = Calendar.current.component(.year, from: Date())
                        let lastThreeYears = [currentYear, currentYear-1, currentYear-2]
                        
                        if let launchDate = Date.dateFromUTCServerDate(date: launch.date_utc), lastThreeYears.contains(Calendar.current.component(.year, from: launchDate)) {
                            
                            let successfulLaunch = (launch.success == true)
                            let upcomingLaunch = launchDate > Date()
                            
                            if successfulLaunch || upcomingLaunch  {
                                return true
                            } else {
                                return false
                            }
                        }
                        
                        return false
                    })
                    self?.launches = filtedLaunchhes
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showAPIError(message: error.localizedDescription)
                }
            }
        }
    }
}

extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let launch = self.launches[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: LaunchListTableViewCell.nameOfClass, for: indexPath) as? LaunchListTableViewCell {
            cell.configure(with: launch)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = self.launches[indexPath.row]
        RocketsViewController.present(from: self, rocketId: launch.rocket)
    }
    
}

