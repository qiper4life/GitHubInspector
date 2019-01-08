//
//  LoginViewController.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 1/8/19.
//  Copyright © 2019 Volodya wovan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginView {
    
    weak var presenter: LoginModuleInterface?
    
    @IBOutlet var gitLogoImageView: UIImageView!
    var rocketImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        presenter?.continueLogin()
    }
    
    private var viewIsSetUp = false
    
    override func viewDidLayoutSubviews() {
        if !viewIsSetUp {
            addRocketAnimation()
        }
        viewIsSetUp = true
    }
    
    fileprivate func addRocketAnimation() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window!
        let newRocketCircleFrame = self.view.convert(gitLogoImageView.frame, to: window)
        
        let rocketFrame = CGRect(origin: newRocketCircleFrame.origin, size: CGSize(width: 80, height: 40))
        let rocketImageView = UIImageView(frame: rocketFrame)
        rocketImageView.image = UIImage(named: "Rocket")
        
        window?.addSubview(rocketImageView)
        
        let boundingRect = gitLogoImageView.bounds
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position";
        orbit.path = CGPath.init(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 4
        orbit.isAdditive = true
        orbit.repeatCount = Float.infinity
        orbit.calculationMode = kCAAnimationPaced
        orbit.rotationMode = kCAAnimationRotateAutoReverse
        rocketImageView.layer.add(orbit, forKey: "orbit")
    }

}

