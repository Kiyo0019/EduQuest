import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "square.grid.2x2.fill")
                }

            SubjectsView()
                .tabItem {
                    Label("Subjects", systemImage: "books.vertical.fill")
                }

            LeaderboardView()
                .tabItem {
                    Label("Leaderboard", systemImage: "chart.bar.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
