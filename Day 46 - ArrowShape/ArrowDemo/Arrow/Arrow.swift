//
//  Arrow.swift
//  Drawing
//
//  Created by Tobias Dunkel on 15.11.22.
//

import SwiftUI

struct Arrow: Shape {
    
    var width: Double
    var startPoint: CGPoint
    var endPoint: CGPoint
    var midPoint: CGPoint
    
    var animatableData: Double {
        get {
            width
        }
        set {
            width = newValue
        }
    }
    
    var headLength: Double {
        Double.maximum(width * 4, 20)
    }
    
    var headWidth: Double {
        Double.maximum(width * 3, 25)
    }
    

    var headPoint: CGPoint {
        let distanceToMid = sqrt(pow(endPoint.x - midPoint.x, 2) + pow(endPoint.y - midPoint.y, 2))
        let distance: CGFloat = -headLength
        let distanceRatio = distance/distanceToMid
        let x = (1 - distanceRatio) * endPoint.x + distanceRatio * midPoint.x
        let y = (1 - distanceRatio) * endPoint.y + distanceRatio * midPoint.y
        return CGPoint(x: x, y: y)
    }
    
    var headAngle: Double {
        let angle = -atan((midPoint.x - endPoint.x) / (midPoint.y - endPoint.y))
        return angle + (midPoint.y > endPoint.y ? Double.pi : 0)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, control: midPoint)
        path = path.strokedPath(.init(lineWidth: width,lineJoin: .miter))

    
        var head = Path()
        head.move(to: headPoint)
        head.addLine(to: CGPoint(x: headPoint.x + headWidth / 2, y: headPoint.y - headLength))
        head.addLine(to: CGPoint(x: headPoint.x - headWidth / 2, y: headPoint.y - headLength))
        head.addLine(to: headPoint)
        head = head.applying(
            .init(translationX: -headPoint.x, y: -headPoint.y)
            .concatenating(.init(rotationAngle: headAngle))
            .concatenating(.init(translationX: headPoint.x, y: headPoint.y))
        )
        head.closeSubpath()
        path.addPath(head)
 
        return path
    }
    
    init(startPoint: CGPoint, endPoint: CGPoint, width: Double) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.midPoint = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        self.width = width
    }
    
    init(startPoint: CGPoint, endPoint: CGPoint, midPoint: CGPoint, width: Double) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.midPoint = midPoint
        self.width = width
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow(startPoint: .init(x: 100, y: 100), endPoint: .init(x: 200, y: 200), midPoint: .init(x: 150, y: 120), width: 20)
            .fill()
    }
}
