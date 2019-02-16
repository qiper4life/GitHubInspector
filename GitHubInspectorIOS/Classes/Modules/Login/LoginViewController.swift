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
    
    @IBAction func startButtonPressed(_ sender: Any) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDependencies.shared.gitAccount.token = nil
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

extension LoginViewController {
    override var description: String {
        let lyrics =
        """
I'm too sexy for my love
Too sexy for my love
Love's going to leave me
I'm too sexy for my shirt
Too sexy for my shirt
So sexy it hurts
And I'm too sexy for Milan
Too sexy for Milan
New York, and Japan
I'm too sexy for your party
Too sexy for your party
No way I'm disco dancing
'Cause I'm a model, you know what I mean
And I do my little turn on the catwalk
Yeah, on the catwalk
On the catwalk, yeah
I shake my little tush on the catwalk
I'm too sexy for my car
Too sexy for my car
Too sexy by far
And I'm too sexy for my hat
Too sexy for my hat
What do you think about that?
'Cause I'm a model, you know what I mean
And I do my little turn on the catwalk
Yeah, on the catwalk
On the catwalk, yeah
I shake my little tush on the catwalk
Too sexy for my
Too sexy for my
Too…
"""
        return lyrics
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
        var newRocketCircleFrame = self.view.convert(gitLogoImageView.frame, to: window)
        newRocketCircleFrame.origin.x = newRocketCircleFrame.origin.x - 30
        newRocketCircleFrame.origin.y = newRocketCircleFrame.origin.y - 30
        newRocketCircleFrame.size.width = newRocketCircleFrame.size.width + 60
        newRocketCircleFrame.size.height = newRocketCircleFrame.size.height + 60
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
        self.rocket?.layer.removeAnimation(forKey: "orbit")
        
        CATransaction.begin()
        layer.setAffineTransform(CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 1.25)))
        let flyAwayRotation = CABasicAnimation(keyPath: "transform.rotation")
        
        flyAwayRotation.fromValue = layer.presentation()?.value(forKeyPath: "transform.rotation")
        flyAwayRotation.toValue = Double.pi * 1.25
        flyAwayRotation.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.5, 0, 0.9, 0.7) //[CAMediaTimingFunction functionWithControlPoints:0.5:0:0.9:0.7];
        flyAwayRotation.repeatCount = 1
        flyAwayRotation.duration = 0.3
        
        let flyAwayPosition = CABasicAnimation(keyPath: "position")
        flyAwayPosition.fromValue = layer.presentation()?.value(forKeyPath: "position")
        let size = UIScreen.main.bounds.size
        flyAwayPosition.toValue = NSValue(cgPoint:(CGPoint(x: size.width, y: size.height)))
        flyAwayPosition.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.5, 0, 0.9, 0.7)
        
        CATransaction.setCompletionBlock { [weak self] in
            self?.removeRocket()
        }
        let flyAway = CAAnimationGroup()
        flyAway.animations = [flyAwayRotation, flyAwayPosition]
        flyAway.duration = 0.6
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
        failure.duration = 3.0
        
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
