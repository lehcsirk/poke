//
//  ViewController.swift
//  poke
//
//  Created by Cameron Krischel on 2/13/19.
//  Copyright © 2019 Cameron Krischel. All rights reserved.
//

import UIKit
import QuartzCore

let defaults = UserDefaults.standard

let screenSize: CGRect = UIScreen.main.bounds
var counter = [10]
let copyCounter = defaults.array(forKey: "savedCounter")  as? [Int] ?? [Int]()
let copyX = defaults.array(forKey: "savedX")  as? [Int] ?? [Int]()
let copyY = defaults.array(forKey: "savedY")  as? [Int] ?? [Int]()
let copyColor = defaults.array(forKey: "savedColor")  as? [CGFloat] ?? [CGFloat]()
let copyWin = defaults.array(forKey: "savedWin")  as? [Int] ?? [Int]()

let setWidth = Int(screenSize.width)
let setHeight = Int(screenSize.width)
let shrinkConst = (setWidth-80)/10

extension CGFloat
{
    static func random() -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor
{
    static func random() -> UIColor
    {
        var red = CGFloat(.random())
        var green = CGFloat(.random())
        var blue = CGFloat(.random())
        defaults.set([red, green, blue], forKey: "savedColor")
        return UIColor(red:   red,
                       green: green,
                       blue:  blue,
                       alpha: 1.0)
        
    }
}
class ViewController: UIViewController
{
    @IBOutlet weak var myButton: UIButton!
    @IBAction func startButton(_ sender: Any)
    {
        if(myButton.titleLabel!.text == "Win!")
        {
            counter[0] = 10
            myButton.frame = CGRect(x: Int(myButton.center.x), y: Int(myButton.center.y), width: setWidth - shrinkConst*(10-counter[0]), height: setHeight-shrinkConst*(10-counter[0]))
            myButton.backgroundColor = .random()
            defaults.set([0],         forKey: "savedWin")
            myButton.setTitle(String(counter[0]), for: .normal)
            myButton.center.x = CGFloat(screenSize.width/2)
            myButton.center.y = CGFloat(screenSize.height/2)
        }
        else
        {
            myButton.backgroundColor = .random()
            let randX = Int.random(in: 0 ... Int(screenSize.width)-Int(myButton.frame.width))
            let randY = Int.random(in: 0 ... Int(screenSize.height) - Int(myButton.frame.height))
            myButton.center.x = CGFloat(randX)
            myButton.center.y = CGFloat(randY)
            counter[0] -= 1
            
            myButton.setTitle(String(counter[0]), for: .normal)
            myButton.frame = CGRect(x: Int(myButton.center.x), y: Int(myButton.center.y), width: setWidth-shrinkConst*(10-counter[0]), height: setHeight-shrinkConst*(10-counter[0]))
            
            if(counter[0] <= 0)
            {
                myButton.setTitle("Win!", for: .normal)
                myButton.center.x = CGFloat(screenSize.width/2)
                myButton.center.y = CGFloat(screenSize.height/2)
                defaults.set([1],         forKey: "savedWin")
            }
        }
        let tempWidth = setWidth-shrinkConst*(10-counter[0])
        let tempHeight = setHeight-shrinkConst*(10-counter[0])
        myButton.center.x = CGFloat(Int(myButton.frame.minX) + tempWidth/2)
        myButton.center.y = CGFloat(Int(myButton.frame.minY) + tempHeight/2)
        defaults.set(counter,         forKey: "savedCounter")
        defaults.set([myButton.center.x],         forKey: "savedX")
        defaults.set([myButton.center.y],         forKey: "savedY")
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myButton.layer.cornerRadius = 10; // this value vary as per your desire
        myButton.clipsToBounds = true
       

        if(copyColor.count > 0)
        {
            myButton.backgroundColor = UIColor(red:   copyColor[0],
                                               green: copyColor[1],
                                               blue:  copyColor[2],
                                               alpha: 1.0)
        }
        else
        {
            myButton.backgroundColor = .random()
        }
        
        
        if(copyCounter.count > 0)
        {
            counter[0] = copyCounter[0]
        }
        if(copyX.count > 0)
        {
            myButton.center.x = CGFloat(copyX[0])
        }
        else
        {
            myButton.center.x = CGFloat(screenSize.width/2)
        }
        if(copyY.count > 0)
        {
            myButton.center.y = CGFloat(copyY[0])
        }
        else
        {
            myButton.center.y = CGFloat(screenSize.height/2)
        }
        if(copyWin.count > 0)
        {
            if(copyWin[0] == 1)
            {
                //defaults.set([0],         forKey: "savedWin")
                myButton.setTitle("Win!", for: .normal)

            }
            else
            {
                myButton.setTitle(String(counter[0]), for: .normal)
            }
        }
        
        let tempWidth = setWidth-shrinkConst*(10-counter[0])
        let tempHeight = setHeight-shrinkConst*(10-counter[0])
        
        myButton.frame = CGRect(x: Int(myButton.center.x) - tempWidth/2, y: Int(myButton.center.y)-tempHeight/2, width: tempWidth, height: tempHeight)
        myButton.center.x = CGFloat(Int(myButton.frame.minX) + tempWidth/2)
        myButton.center.y = CGFloat(Int(myButton.frame.minY) + tempHeight/2)
        defaults.set([myButton.center.x],         forKey: "savedX")
        defaults.set([myButton.center.y],         forKey: "savedY")
        
//        self.myButton.titleLabel!.adjustsFontForContentSizeCategory = true
        self.myButton.titleLabel?.minimumScaleFactor = 0.0001
        self.myButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.myButton.titleLabel?.numberOfLines = 0

        self.myButton.titleLabel!.baselineAdjustment = .alignCenters

//        self.myButton.clipsToBounds = true
        self.myButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
    }


}

