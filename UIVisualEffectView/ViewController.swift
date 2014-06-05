//
//  ViewController.swift
//  UIVisualEffectView
//
//  Created by Andrei Puni on 03/06/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var backgroundImage: UIImageView
    @IBOutlet var titleLabel: UILabel
    
    func loadItem(#title: String, image: String) {
        self.backgroundImage.image = UIImage(named: image)
        self.titleLabel.text = title
    }
}

extension Array {
    func each(callback: T -> ()) {
        for item in self {
            callback(item)
        }
    }

    func eachWithIndex(callback: (T, Int) -> ()) {
        var index = 0
        for item in self {
            callback(item, index)
            index += 1
        }
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView
    
    
    var items: (String, String)[] = [
        ("❤", "swift 1.jpeg"),
        ("We", "swift 2.jpeg"),
        ("❤", "swift 3.jpeg"),
        ("Swift", "swift 4.jpeg"),
        ("❤", "swift 5.jpeg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = self
        let effectViewHeight = 30

        func addVisualEffectClosure(effect: UIVisualEffect, offset: Float) {
            var effectView: UIVisualEffectView = UIVisualEffectView(effect: effect)
            
            let effectViewWidth = Float(viewController.view.frame.size.width)
            
            effectView.frame =
                CGRectMake(0.0, CGFloat(offset), CGFloat(effectViewWidth), CGFloat(effectViewHeight))
            
            self.view.addSubview(effectView)
        }
        
        [
            UIBlurEffectStyle.Dark,
            UIBlurEffectStyle.ExtraLight,
            UIBlurEffectStyle.Light
        ].map {
            UIBlurEffect(style: $0)
        }.eachWithIndex {
            let (effect, index) = $0
            addVisualEffectClosure(effect, Float(effectViewHeight * index))
        }
        
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        self.tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as CustomTableViewCell
    
        var (title, image) = items[indexPath.row]
        
        cell.loadItem(title: title, image: image)
    
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
    }
}

