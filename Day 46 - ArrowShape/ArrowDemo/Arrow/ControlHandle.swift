//
//  ControlHandle.swift
//  Drawing
//
//  Created by Tobias Dunkel on 15.11.22.
//

import SwiftUI

struct ControlHandle: View {
    var body: some View {
        Circle()
            .fill(.orange)
            .frame(width: 24, height: 24)
            .overlay {
                Circle()
                    .strokeBorder(lineWidth: 1)
            }
    }
}

struct ControlHandle_Previews: PreviewProvider {
    static var previews: some View {
        ControlHandle()
            .previewLayout(.sizeThatFits)
    }
}
