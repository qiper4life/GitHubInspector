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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        startAnimationAct1()
        presenter?.performLogin()
    }
    
    func loginSucceded() {
        DispatchQueue.onMain {
            self.startAnimationAct2()
            self.presenter?.continueLogin()
        }
    }
    
    func loginFailed() {
        DispatchQueue.onMain {
            self.failureAnimation()
        }
    }
    
    fileprivate var rocket: UIImageView?
    fileprivate var currentTransform: CGAffineTransform?
    
    
    enum CurrentAnimationState {
        
        typealias AnimationKey = String
        
        case none
        case flyawayAct1(CAAnimation, AnimationKey)
        case flyawayAct2(CAAnimation, AnimationKey)
        case faliure(CAAnimation, AnimationKey)
    }
    
    fileprivate var currentAnimationState: CurrentAnimationState = .none
    
    @objc
    func didEnterBackground() {
        switch currentAnimationState {
        case .none: break
        case .flyawayAct1(_, _),
             .flyawayAct2(_, _),
             .faliure(_, _):
            let layer = rocket!.layer
            self.pauseLayer(layer)
        }
    }
    
    @objc
    func willEnterForeground() {
        let animation: CAAnimation
        let key: String
        switch currentAnimationState {
        case .none: return
        case .flyawayAct1(let savedAnimation, let savedKey):
            animation = savedAnimation
            key = savedKey
        case .flyawayAct2(let savedAnimation, let savedKey):
            animation = savedAnimation
            key = savedKey
        case .faliure(let savedAnimation, let savedKey):
            animation = savedAnimation
            key = savedKey
        }
        let layer = rocket!.layer
        layer.add(animation, forKey: key)
        self.resumeLayer(layer)
    }
    
    func pauseLayer(_ layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(_ layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
}

extension DispatchQueue {
    static func onMain(block: @escaping () -> ()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async(execute: block)
        }
    }
}

extension LoginViewController: CALayerDelegate {
    
    func startAnimationAct1() {
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
        self.rocket = rocketImageView
        self.currentAnimationState = .flyawayAct1(orbit, "orbit")
    }
    
    func startAnimationAct2() {
        let layer = rocket!.layer
        
        CATransaction.begin()
        let flyAway = CABasicAnimation(keyPath: "transform.rotation")
        flyAway.fromValue = layer.presentation()?.value(forKeyPath: "transform.rotation")
        flyAway.toValue = -Double.pi
        flyAway.duration = 1.0
        
        CATransaction.setCompletionBlock { [weak self] in
            self?.removeRocket()
        }
        self.rocket?.layer.removeAnimation(forKey: "orbit")
        layer.add(flyAway, forKey: "flyAway")
        CATransaction.commit()
        self.currentAnimationState = .flyawayAct2(flyAway, "flyAway")
    }
    
    func failureAnimation() {
        
        self.rocket?.layer.removeAnimation(forKey: "orbit")
        self.rocket?.layer.removeAnimation(forKey: "flyAway")
        let layer = rocket!.layer
        
        CATransaction.begin()
        
        let failure = CABasicAnimation(keyPath: "transform.rotation")
        failure.fromValue = 0.0
        failure.toValue = Double.pi
        failure.duration = 1.0
        
        CATransaction.setCompletionBlock { [weak self] in
            self?.removeRocket()
        }
        layer.add(failure, forKey: "failure")
        CATransaction.commit()
        self.currentAnimationState = .faliure(failure, "failure")
    }
    
    
    func removeRocket() {
        self.rocket?.removeFromSuperview()
        self.rocket = nil
        self.currentAnimationState = .none
    }
}
