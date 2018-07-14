//
//  ViewController.swift
//  animation-canteen-challenge
//
//  Created by Yoshua Elmaryono on 13/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var squaresDictionary: [String: SquareView] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let minX = Int(view.frame.minX)
        let minY = Int(view.frame.minY)
        let maxX = Int(view.frame.maxX)
        let maxY = Int(view.frame.maxY)
        for x in stride(from: minX, through: maxX, by: 40) {
            for y in stride(from: minY, through: maxY, by: 40) {
                let squareView = SquareView(x: x, y: y)
                view.addSubview(squareView)
                squaresDictionary["\(x/40),\(y/40)"] = squareView
            }
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(touches.first?.location(in: view))
//    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let coordinate = touches.first?.location(in: view)
        let x = Int(coordinate!.x / 40)
        let y = Int(coordinate!.y / 40)
        let squareView: SquareView = squaresDictionary["\(x),\(y)"]!
        squareView.touched()
    }

}

class SquareView: UIView {
    convenience init(x: Int, y: Int) {
        let sides = 40
        let squareFrame = CGRect(x: x, y: y, width: sides, height: sides)
        
        self.init(frame: squareFrame)
        self.backgroundColor = getRandomColor()
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touched() {
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = self.getRandomColor(previousColor: self.backgroundColor)
            self.transform = CGAffineTransform.identity
        }
    }
    
    func getRandomColor(previousColor: UIColor? = nil) -> UIColor {
        let colors_possible = [UIColor.red, .yellow, .blue, .green]
        let random_index = Int(arc4random_uniform(UInt32(colors_possible.count)))
        let color = colors_possible[random_index]
        if(previousColor == color){
            return colors_possible[(random_index + 1) % colors_possible.count]
        }else{
            return color
        }
    }
}

