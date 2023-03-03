//
//  TabBarDrawer.swift
//  RxSwiftMVVM
//
//  Created by User on 02.03.2023.
//

import UIKit

public class TabBarDrawer {
    private let positionOnX: CGFloat = 10
    private let positionOnY: CGFloat = 14
    private let width: CGFloat
    private let height: CGFloat
    private let itemWidth: CGFloat
    private var circleCenter: CGPoint
    private var beforCiclePoint: CGPoint
    private let beetweenInset: CGFloat
    private let itemsCount = 3
    private var caShapeLayer: CAShapeLayer?
    private var tabBar: UITabBar?
    var selectedItem = 1 {
        didSet {
            circleCenter = CGPoint(
                x: itemWidth * CGFloat(selectedItem) + beetweenInset * CGFloat(selectedItem) / 2 + positionOnX * CGFloat(selectedItem - 1),
                y: 0)
            prepareForEditing()
        }
    }
    
    init(tabBarBounds: CGRect) {
        let width = tabBarBounds.width - positionOnX * 2
        self.width = width
        height = tabBarBounds.height + positionOnY * 2
        itemWidth = width / 5
        circleCenter = CGPoint(x: width / 2 + positionOnX, y: 0)
        beforCiclePoint = CGPoint(x: width / 2, y: 0)
        beetweenInset = (width - CGFloat(itemsCount) * itemWidth) / CGFloat(itemsCount + 1)
    }
    
    public func setLayer(for tabBar: UITabBar) {
        self.tabBar = tabBar
        let layer = createLayer()
        tabBar.layer.insertSublayer(layer, at: 0)
        self.caShapeLayer = layer
        tabBar.itemWidth = itemWidth
        tabBar.itemPositioning = .centered
    }
    
    private func createLayer() -> CAShapeLayer {
        let roundLayer = CAShapeLayer()
        roundLayer.path = createPath()
        return roundLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: positionOnX + height / 2, y: 0))
        path.addArc(
            withCenter: circleCenter,
            radius: 10 + itemWidth / 2,
            startAngle: .pi, endAngle: 2 * .pi, clockwise: false)
        path.addLine(to: CGPoint(x: width + positionOnX - height / 2, y: 0))
        path.addArc(
            withCenter: CGPoint(x: width + positionOnX - height / 2, y: height / 2),
            radius: height / 2,
            startAngle: 3 * .pi / 2,
            endAngle: .pi / 2,
            clockwise: true)
        path.addLine(to: CGPoint(x: positionOnX + height / 2, y: height))
        path.addArc(withCenter: CGPoint(x: positionOnX + height / 2, y: height / 2), radius: height / 2, startAngle: .pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        path.close()
        return path.cgPath
    }
    
    func prepareForEditing(){
        let animation = CABasicAnimation(keyPath: "path")
        let path = createPath()
        animation.duration = 0.2
        animation.fromValue = caShapeLayer?.path
        caShapeLayer?.path = path
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        caShapeLayer?.add(animation, forKey: "path")
      }
}
