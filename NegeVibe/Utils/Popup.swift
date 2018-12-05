//
//  Popup.swift
//  NegeVibe
//
//  Created by Ran Loock on 05/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit


func popAlert(title: String, message: String, view: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
        alert.dismiss(animated: true)
    }))
    
    view.present(alert, animated: true, completion: nil)
    
}

func popAlert(title: String, message: String, okMessage: String, view: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: okMessage, style: .cancel, handler: { (action) in
        alert.dismiss(animated: true)
    }))
    
    view.present(alert, animated: true, completion: nil)
    
}
