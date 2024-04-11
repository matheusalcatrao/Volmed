//
//  LoadingView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 11/03/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView() {
                Text("Loading...")
                    .padding(15)
                    .font(.title2)
                    .bold()
            }
        }
    }
}

#Preview {
    LoadingView()
}
