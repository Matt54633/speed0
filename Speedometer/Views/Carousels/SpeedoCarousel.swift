//
//  SpeedoCarousel.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI

struct SpeedoCarousel: View {
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.horizontal) {
                VStack {
                    LazyHStack {
                        Group {
                            NeonSpeedo()
                            DefaultSpeedo()
                            SportSpeedo()
                            DigitalSpeedo()
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    .scrollTargetLayout()
                    
                }
            }
            .scrollIndicators(.never)
            .scrollTargetBehavior(.viewAligned)
          
        }
    }
}

#Preview {
    SpeedoCarousel()
}
