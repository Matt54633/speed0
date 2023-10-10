//
//  ControlCarousel.swift
//  Speedometer
//
//  Created by Matt Sullivan on 30/12/2023.
//

import SwiftUI

struct ControlCarousel: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
                .frame(height: 75)
                .padding(.horizontal)
            HStack
            {
                AvgSpeedView()
                AddCameraView()
            }
        }
    }
}

#Preview {
    ControlCarousel()
}
