//
//  UIViewController+Extension.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 27/03/21.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showProgressView(disableInteraction: Bool = false) {
        if disableInteraction {
            self.view.isUserInteractionEnabled = false
        }

        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: self.view, animated: true)
            let _ = MBProgressHUD.showAdded(to: self.view, animated: true)
        })
    }

    func hideProgressView() {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
        })
    }

    
    func showAPIError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let refreshAction = UIAlertAction(title: "Refresh", style: .default) { [weak self] alertAction in
            //self?.tableView.reloadData()
        }
        alertController.addAction(okAction)
        alertController.addAction(refreshAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func openInSafari(url : String?) {
        if let urlString = url, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

