//
//  ProfileView.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.99, green: 1.0, blue: 1.0),
                    Color(red: 0.95, green: 0.98, blue: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(Color.blue)

                Text("Profile")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primary)

                Text("Profile features can be added here next.")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.secondary)
            }
            .padding(24)
        }
    }
}

#Preview {
    ProfileView()
}
