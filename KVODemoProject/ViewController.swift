//
//  ViewController.swift
//  KVODemoProject
//
//  Created by 张平 on 2020/4/30.
//  Copyright © 2020 CN. All rights reserved.
//

//Swift自动KVO示例程序

import UIKit

class Person:NSObject{
   
    init(age:Int, name:String) {
        self.age = age
        self.name = name
    }
    
  @objc dynamic var age:Int 
  @objc dynamic var name:String
    
    func add() {
        self.age += 1
    }
}

private var myContext = 0
private var myContext1 = 1

class ViewController: UIViewController {

    var jack = Person(age: 12, name: "jack")
    var rose = Person(age: 12, name: "rose")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 60)
        
        button.setTitle("点我啊", for: .normal)
        button.addTarget(self, action: #selector(method1), for: .touchUpInside)
        button.tintColor = .blue
        self.view.addSubview(button)
        
        jack.addObserver(self, forKeyPath: "age", options: [.new,.old], context: &myContext)
        jack.addObserver(self, forKeyPath: "name", options: [.new,.old], context: &myContext1)
        
        
    }
    @objc func method1(){
        
        //self.jack.setValuesForKeys(["age": 12, "name": "jackMa"])
        self.jack.age += 1
        self.jack.name = "JackMa"
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &myContext {
            if let newAge = change?[NSKeyValueChangeKey.newKey],let oldAge = change?[NSKeyValueChangeKey.oldKey] {
                print("last year she was \(oldAge)years old")
                print("but now she is already is \(newAge)")
            }
        }
        else if context == &myContext1 {
            if let newValue = change?[NSKeyValueChangeKey.newKey], let oldName = change?[NSKeyValueChangeKey.oldKey]{
                print("new name is: \(newValue)")
                print("and old name is \(oldName)")
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
}

