//
//  BaseViewController.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }    

    func showErrorView(title: String, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgressHud(view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.1)
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
    }
    
    func hideProgressHud(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }

}
