//
//  RocketsViewController.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class RocketsViewController: UIViewController {
    
    @IBOutlet weak var lblRocketName : UILabel!
    @IBOutlet weak var lblRocketDetails : UILabel!
    @IBOutlet weak var btnMoreDetails : UIButton!
    @IBOutlet weak var rocketImageCollectionView : UICollectionView!
    @IBOutlet weak var rocketImagePageControl : UIPageControl!
    
    let disposeBag = DisposeBag()
    private var viewModel : RocketDetailsViewModelProtocol!
    private var rocketViewModel : RocketViewModel?
    
    static func instantiate(viewModel : RocketDetailsViewModelProtocol) -> RocketsViewController {
        let storyboard = UIStoryboard.main
        let viewController = storyboard.instantiateViewController(withIdentifier: self.nameOfClass) as! RocketsViewController
        viewController.viewModel = viewModel
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViews()
        fetchData()
    }
    
    func setupUI() {
        
        self.rocketImageCollectionView.contentInsetAdjustmentBehavior = .never
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: self.view.frame.width, height: rocketImageCollectionView.frame.height)
        rocketImageCollectionView.collectionViewLayout = flowLayout
        
        rocketImageCollectionView.registerXibs(identifiers: [MImageCollectionViewCell.nameOfClass])
        
        
        rocketImagePageControl.hidesForSinglePage = true
        rocketImagePageControl.addTarget(self, action: #selector(pageControllerValueChange(_:)), for: .valueChanged)
    }
    
    func bindViews() {
        viewModel.images.observe(on: MainScheduler.instance).bind(to: rocketImageCollectionView.rx.items(cellIdentifier: MImageCollectionViewCell.nameOfClass, cellType: MImageCollectionViewCell.self)) {  (row, item, cell) in
                cell.configureWithImageUrl(item)
            }.disposed(by: disposeBag)
        
        rocketImageCollectionView.rx.didEndDecelerating.subscribe(onNext: { _ in
            self.rocketImagePageControl.currentPage = Int(self.rocketImageCollectionView.contentOffset.x) / Int(self.rocketImageCollectionView.frame.width)
        }).disposed(by: disposeBag)

    }
    
    func fetchData() {
        viewModel.fetchRocketViewModel().observe(on: MainScheduler.instance).subscribe { (rocketDetail) in
            DispatchQueue.main.async {
                self.configureUI(with: rocketDetail)
            }
        } onError: { (error) in
            self.showAPIError(message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func configureUI(with rocket : RocketViewModel) {
        self.rocketViewModel = rocket
        
        self.lblRocketName.text = rocket.name
        self.lblRocketDetails.text = rocket.details
        rocketImagePageControl.numberOfPages = rocket.images.count
        
        self.rocketImageCollectionView.reloadData()
    }
    
    @objc func pageControllerValueChange(_ sender : UIPageControl) {
        let page = sender.currentPage
        var frame: CGRect = self.rocketImageCollectionView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.rocketImageCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    @IBAction func actionDetails() {
        self.viewModel.didTapMoreDetails()
    }
}
