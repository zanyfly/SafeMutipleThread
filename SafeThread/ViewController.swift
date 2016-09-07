//
//  ViewController.swift
//  SafeThread
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var value: String = ""
    
    let myQueue: dispatch_queue_t = dispatch_queue_create("com.ivanzeng.safequeue", DISPATCH_QUEUE_CONCURRENT)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       { () -> Void in
                    self.freshValue("We love Soccer")
        })

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       { () -> Void in
                        self.freshValue("We love China")
        })

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       { () -> Void in
                        self.freshValue("We love Ivan")
        })

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //设置新值时竖立栅栏，保护
    func freshValue(newValue: String) {
        dispatch_barrier_sync(myQueue,  { () -> Void in
            self.value = newValue
            print("new value is \(newValue)")

        })
        
    }
    
    //异步读取当前值
    func getValue() -> String {
        
        var tempValue:String = ""
        
        dispatch_async(myQueue,   { () -> Void in
            tempValue = self.value
        })
        
        return tempValue
    }
    

}

