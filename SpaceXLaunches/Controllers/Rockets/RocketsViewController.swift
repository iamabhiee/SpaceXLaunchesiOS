//
//  RocketsViewController.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import UIKit

extension UICollectionView {
    func registerXibs(identifiers : [String]) {
        identifiers.forEach { (identifier) in
            self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
}

class RocketsViewController: UIViewController {
    
    @IBOutlet weak var lblRocketName : UILabel!
    @IBOutlet weak var lblRocketDetails : UILabel!
    @IBOutlet weak var btnMoreDetails : UIButton!
    @IBOutlet weak var rocketImageCollectionView : UICollectionView!
    @IBOutlet weak var rocketImagePageControl : UIPageControl!
    
    var rocketId : String? = nil
    var rocket : Rocket? = nil
    
    class func present(from cotroller : UIViewController, rocketId : String?) {
        if let vc = UIStoryboard.main.instantiateViewController(withIdentifier: self.classIdentifier) as? RocketsViewController {
            vc.rocketId = rocketId
            cotroller.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.rocketImageCollectionView.contentInsetAdjustmentBehavior = .never

        setupUI()
        fetchData()
    }
    
    func setupUI() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: self.view.frame.width, height: rocketImageCollectionView.frame.height)
        rocketImageCollectionView.collectionViewLayout = flowLayout
        
        rocketImageCollectionView.registerXibs(identifiers: [MImageCollectionViewCell.nameOfClass])
        rocketImageCollectionView.dataSource = self
        rocketImageCollectionView.delegate = self
        
        rocketImagePageControl.hidesForSinglePage = true
        rocketImagePageControl.addTarget(self, action: #selector(pageControllerValueChange(_:)), for: .valueChanged)
    }
    
    func fetchData() {
        guard let rocketId = rocketId else {
            return
        }
        
        self.showProgressView()
        let service = RocketsServiceRequests()
        service.getRockets(id: rocketId, completion: { [weak self] apiResult in
            DispatchQueue.main.async {
                self?.hideProgressView()
                switch apiResult {
                case .success(let rocket):
                    self?.rocket = rocket
                    self?.configureUI(with: rocket)
                    break
                case .failure(let error):
                    self?.showAPIError(message: error.localizedDescription)
                }
            }
        })
    }
    
    func configureUI(with rocket : Rocket?) {
        self.lblRocketName.text = rocket?.name
        self.lblRocketDetails.text = rocket?.description
        rocketImagePageControl.numberOfPages = rocket?.flickr_images?.count ?? 0
        
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
        self.openInSafari(url: self.rocket?.wikipedia)
    }
}

extension RocketsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rocket?.flickr_images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MImageCollectionViewCell.nameOfClass, for: indexPath) as? MImageCollectionViewCell {
            if let image = self.rocket?.flickr_images?[indexPath.item] {
                cell.configureWithImageUrl(image)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.delegate?.didTapMedia(at: indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        rocketImagePageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
