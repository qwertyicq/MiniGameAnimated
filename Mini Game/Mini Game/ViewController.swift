//
//  ViewController.swift
//  Mini Game
//
//  Created by Nikolay T on 11.07.2021.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var manualAddedView: CircleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manualAddedView.removeFromSuperview()
        
        let rnd = Int.random(in: 3..<7)
        
        for index in 0...rnd {
            appendCircleInArray(index: index)
            view.addSubview(Circle.rounds[index])
        }
    }
    
    func appendCircleInArray(index: Int) {
        let maxXinSafeArea = view.safeAreaLayoutGuide.layoutFrame.maxX
        let maxYinSafeArea = view.safeAreaLayoutGuide.layoutFrame.maxY
        let minXinSafeArea = view.safeAreaLayoutGuide.layoutFrame.minX
        let minYinSafeArea = view.safeAreaLayoutGuide.layoutFrame.minY
        
        let randomX = CGFloat.random(in: (minXinSafeArea + 50)..<(maxXinSafeArea - 50))
        let randomY = CGFloat.random(in: (minYinSafeArea + 50)..<(maxYinSafeArea - 50))
        
        Circle.rounds.append(CircleView(frame: CGRect(x: randomX, y: randomY, width: 50, height: 50)))
        Circle.rounds[index].indexInArray = index
        Circle.rounds[index].workingView.backgroundColor = .random()
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

