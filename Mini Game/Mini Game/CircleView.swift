//
//  CircleView.swift
//  Mini Game
//
//  Created by Nikolay T on 11.07.2021.
//

import UIKit

@IBDesignable class CircleView: UIView, UIGestureRecognizerDelegate {
    
    public var workingView: UIView!
    private var xibName: String = "CircleView"
    
    private var lastLocation: CGPoint = .zero
    
    public var indexInArray: Int = 0
    public var isAvalable: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    func getFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: xibName, bundle: bundle)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func setCustomView() {
        workingView = self.getFromXib()
        workingView.frame = bounds
        workingView.layer.cornerRadius = frame.size.width / 2
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        pan.delegate = self
        workingView.addGestureRecognizer(pan)

        addSubview(workingView)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        //guard let movingView = sender.view else { return }
        let translation = sender.translation(in: sender.view)
        
        self.center = CGPoint(x: lastLocation.x + translation.x,
                              y: lastLocation.y + translation.y)
        
        lastLocation = self.center
        sender.setTranslation(.zero, in: sender.view)
        
        guard sender.state == .ended else { return }
        
        let (isEat, indexOfBigger) = Circle.moved(self)
        
        if isEat && (indexOfBigger == nil) {
            UIView.animate(withDuration: 1, delay: 0.2, options: .curveLinear) {
                self.workingView.frame.size = CGSize(width: self.workingView.frame.size.width * 1.3, height: self.workingView.frame.size.height * 1.3)
                self.workingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: (1 - (self.workingView.frame.size.width / 255)), alpha: 1.0)
                self.workingView.layer.cornerRadius = self.workingView.frame.size.width / 2
                self.workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            } completion: { _ in
                self.lastLocation = self.workingView.center
                Circle.reorderInArray()
            }
        } else if isEat && (indexOfBigger != nil) {
            UIView.animate(withDuration: 1, delay: 0.2, options: .curveLinear) {
                Circle.rounds[indexOfBigger!].workingView.frame.size = CGSize(width: Circle.rounds[indexOfBigger!].workingView.frame.size.width * 1.3, height: Circle.rounds[indexOfBigger!].workingView.frame.size.height * 1.3)
                Circle.rounds[indexOfBigger!].workingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: (1 - (Circle.rounds[indexOfBigger!].workingView.frame.size.width / 255)), alpha: 1.0)
                Circle.rounds[indexOfBigger!].workingView.layer.cornerRadius = Circle.rounds[indexOfBigger!].workingView.frame.size.width / 2
                Circle.rounds[indexOfBigger!].lastLocation = Circle.rounds[indexOfBigger!].workingView.center
            } completion: { _ in
                Circle.reorderInArray()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        superview?.bringSubviewToFront(self)
        lastLocation = self.center
    }
}

