//
//  Circles.swift
//  Mini Game
//
//  Created by Nikolay T on 12.07.2021.
//

import Foundation
import UIKit

class Circle {
    public static var rounds = [CircleView]()
    
    public static func moved(_ view: CircleView) -> (Bool, Int?) {
        for index in 0..<rounds.count {
            if ((((view.frame.minX >= rounds[index].frame.minX) && (view.frame.minX <= rounds[index].frame.maxX))
                    ||
                    ((view.frame.maxX >= rounds[index].frame.minX) && (view.frame.maxX <= rounds[index].frame.maxX)))
                &&
                (((view.frame.minY <= rounds[index].frame.maxY) && (view.frame.minY >= rounds[index].frame.minY))
                    ||
                    ((view.frame.maxY >= rounds[index].frame.minY) && (view.frame.maxY <= rounds[index].frame.maxY))))
            && ((view.indexInArray != index)){
                if view.workingView.frame.size.width >= rounds[index].workingView.frame.size.width {
                    rounds[index].isAvalable = false
                    rounds[index].removeFromSuperview()
                    return (true, nil)
                } else {
                    view.isAvalable = false
                    view.removeFromSuperview()
                    return (true, index)
                }
            }
        }
        return (false, nil)
    }
    
    public static func reorderInArray() {
        for index in 0..<rounds.count {
            if !rounds[index].isAvalable {
                rounds.remove(at: index)
                break
            }
        }
        
        for index in 0..<rounds.count {
            rounds[index].indexInArray = index
        }
    }
}
