//
//  WidgetCarousel.swift
//  Speedometer
//
//  Created by Matt Sullivan on 11/10/2023.
//

import SwiftUI

struct WidgetCarousel: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                Group {
                    MapView()
                        .padding()
                    MusicView()
                        .padding()
                }
                .padding(.top, -12.5)
                .padding(.bottom, 7.5)
                
                .frame(width: UIScreen.main.bounds.width)
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.never)
        .scrollTargetBehavior(.viewAligned)
       
    }
}

#Preview {
    WidgetCarousel()
}
