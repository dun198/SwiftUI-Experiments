//
//  ArrowControlsModifier.swift
//  Drawing
//
//  Created by Tobias Dunkel on 17.11.22.
//

import SwiftUI

extension Arrow {
    func controlsView(startPoint: Binding<CGPoint>, endPoint: Binding<CGPoint>, midPoint: Binding<CGPoint>, editMode: Binding<Bool>) -> some View {
        return self.modifier(ArrowControlsModifier(startPoint: startPoint, endPoint: endPoint, midPoint: midPoint, editMode: editMode))
    }
    
}

struct ArrowControlsModifier: ViewModifier {
    @Binding private var startPoint: CGPoint
    @Binding private var endPoint: CGPoint
    @Binding private var midPoint: CGPoint
    
    @Binding private var editMode: Bool
    
    init(startPoint: Binding<CGPoint>, endPoint: Binding<CGPoint>, midPoint: Binding<CGPoint>, editMode: Binding<Bool>) {
        self._startPoint = startPoint
        self._endPoint = endPoint
        self._midPoint = midPoint
        self._editMode = editMode
    }
    
    func body(content: Content) -> some View {
        let view = ZStack {
            content
            if editMode {
                Group {
                    ControlHandle()
                        .position(x: startPoint.x, y: startPoint.y)
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    startPoint = .init(x: $0.location.x, y: $0.location.y)
                                }
                        )
                    
                    ControlHandle()
                        .position(x: midPoint.x, y: midPoint.y)
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    midPoint = .init(x: $0.location.x, y: $0.location.y)
                                }
                        )
                    
                    ControlHandle()
                        .position(x: endPoint.x, y: endPoint.y)
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    endPoint = .init(x: $0.location.x, y: $0.location.y)
                                }
                        )
                }
            }
        }
        return view
    }
}
