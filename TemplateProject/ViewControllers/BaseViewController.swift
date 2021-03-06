//
//  BaseViewController.swift
//  TemplateProject
//
//  Created by Nikhil Patel on 27/05/19.
//  Copyright © 2019 Nikhil Patel. All rights reserved.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension BaseViewController {
    
    func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func resetNavigationBarTransparancy() {
        self.navigationController?.navigationBar.backgroundColor = Constant.Color.primaryBlue
        self.navigationController?.view.backgroundColor = Constant.Color.primaryBlue
        self.navigationController?.navigationBar.barTintColor = Constant.Color.primaryBlue
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setNavigationTitle(_ title: String = Constant.navigationTitleAppName) {
        self.navigationItem.title = title
    }
    
    func removeBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: nil, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    //    func addBackNavigationButton() {
    //        let button = UIButton.init(type: UIButton.ButtonType.system)
    //        let size: CGFloat = (self.navigationController?.navigationBar.bounds.height ?? 40)
    //        button.frame = CGRect.init(x: 0, y: 0, width: size, height: size)
    //        button.setImage(Constant.Image.icBack, for: UIControl.State.normal)
    //        button.addTarget(self, action: #selector(didTapBackNavigationButton(_:)), for: UIControl.Event.touchUpInside)
    //        button.tintColor = UIColor.white
    //        button.contentHorizontalAlignment = .left
    //        let barButtonItemBack = UIBarButtonItem.init(customView: button)
    //        self.navigationItem.leftBarButtonItem = barButtonItemBack
    //    }
    //
    //    @IBAction func didTapBackNavigationButton(_ sender: UIButton) {
    //        if self.presentedViewController == nil {
    //            self.navigationController?.popViewController(animated: true)
    //        }
    //    }
    
    func dismissPresentedController(animated: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
}

extension BaseViewController {
    
    fileprivate func setupMenuViewController() {
        if SideMenuManager.default.menuLeftNavigationController == nil {
            let menuLeftNavigationController = self.storyboard!.instantiateViewController(withIdentifier: "sideMenu") as! UISideMenuNavigationController
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
            SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
            SideMenuManager.default.menuPresentMode = .viewSlideInOut
            SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuWidth = (UIScreen.main.bounds.width * 0.80)
        }
    }
    
    func addMenuLeftNavigationButton() {
        let button = UIButton.init(type: UIButton.ButtonType.system)
        let size: CGFloat = (self.navigationController?.navigationBar.bounds.height ?? 40)
        button.frame = CGRect.init(x: 0, y: 0, width: size, height: size)
//        button.setImage(Constant.Image.icMenu, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(didTapButtonLeftMenu), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.white
        button.contentHorizontalAlignment = .left
        let barButtonItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @IBAction func didTapButtonLeftMenu(_ sender: UIButton) {
        self.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
}
