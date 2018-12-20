//
//  Toast.swift
//  NegeVibe
//
//  Created by Ran Loock on 20/12/2018.
//  Copyright © 2018 test. All rights reserved.
//
import UIKit

func showToast(message : String, controller: UIViewController) {
    
    let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 75, y: controller.view.frame.size.height / 2, width: 175, height: 40))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 20;
    toastLabel.clipsToBounds  =  true
    controller.view.addSubview(toastLabel)
    UIView.animate(withDuration: 2.5, delay: 0.5, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}

func showToast(message : String, controller: UIViewController, delay: TimeInterval) {
    
    let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 75, y: controller.view.frame.size.height / 2, width: 175, height: 40))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 20;
    toastLabel.clipsToBounds  =  true
    controller.view.addSubview(toastLabel)
    UIView.animate(withDuration: 2.5, delay: delay, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}

func showToast(controller: UIViewController, delay: TimeInterval, image: UIImage, duration: TimeInterval) {
    
    let img = UIImageView(frame: CGRect(x: controller.view.frame.size.width/2 - 100, y: controller.view.frame.size.height / 2 - 100, width: 200, height: 200))
    img.image = image
    img.alpha = 1.0
    img.clipsToBounds = true
    img.contentMode = .scaleAspectFit
    controller.view.addSubview(img)
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
        img.alpha = 0.0
    }, completion: {(isCompleted) in
        img.removeFromSuperview()
    })
    
}

func showToast(message : String, view: UIView, delay: TimeInterval, image: UIImage) {
    
    let img = UIImageView(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height / 2 - 20, width: 175, height: 40))
    img.image = image
    img.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    img.alpha = 1.0
    img.clipsToBounds = true
    img.contentMode = .scaleAspectFit
    img.roundCorners(corners: [.topRight, .topLeft], radius: 20)
    view.addSubview(img)
    let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height / 2 + 20, width: 175, height: 40))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.roundCorners(corners: [.bottomRight, .bottomLeft], radius: 20)
    toastLabel.clipsToBounds  =  true
    view.addSubview(toastLabel)
    UIView.animate(withDuration: 2.5, delay: delay, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
        img.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
        img.removeFromSuperview()
    })
    
}

