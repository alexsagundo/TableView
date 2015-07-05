//
//  ViewController.swift
//  UIVisualEffectView
//
//  Created by Andrei Puni on 03/06/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(#title: String, image: String) {
        backgroundImage.image = UIImage(named: image)
        titleLabel.text = title
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
    
    @IBOutlet var tableView: UITableView!
    
    
    var items: [(String, String)] = [
        ("❤", "swift 1.jpeg"),
        ("We", "swift 2.jpeg"),
        ("❤", "swift 3.jpeg"),
        ("Swift", "swift 4.jpeg"),
        ("❤", "swift 5.jpeg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var viewController = self
        
        addEffects()

        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
    }
    
    func addEffects() {
        [
            UIBlurEffectStyle.Light,
            UIBlurEffectStyle.Dark,
            UIBlurEffectStyle.ExtraLight
        ].map {
            UIBlurEffect(style: $0)
        }.eachWithIndex { (effect, index) in
            var effectView = UIVisualEffectView(effect: effect)
            
            effectView.frame = CGRectMake(0, CGFloat(50 * index), 320, 50)
            
            self.view.addSubview(effectView)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("customCell") as CustomTableViewCell
    
        var (title, image) = items[indexPath.row]
        
        cell.loadItem(title: title, image: image)
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
    }
}

