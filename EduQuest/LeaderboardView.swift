//
//  LeaderboardView.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import SwiftUI

struct LeaderboardView: View {
    @StateObject private var viewModel: LeaderboardViewModel

    init(viewModel: LeaderboardViewModel = LeaderboardViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    headerSection
                    currentRankingCard
                    topThreeSection
                    rankingsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 28)
                .padding(.bottom, 36)
                .frame(maxWidth: 500, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)

            Text(viewModel.subtitle)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(Color.secondary)
        }
    }

    private var currentRankingCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Your Ranking")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.primary)

                    Text("#\(viewModel.currentUserRank) • \(viewModel.currentUser.username)")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.primary)
                }

                Spacer()

                Image(systemName: "person.crop.circle.badge.checkmark")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(Color.blue)
            }

            HStack(spacing: 18) {
                leaderboardMetric(title: "XP", value: "\(viewModel.currentUser.xp)")
                leaderboardMetric(title: "Level", value: "\(viewModel.currentUser.level)")
            }

            ProgressView(value: viewModel.currentUser.progressToNextLevel)
                .progressViewStyle(.linear)
                .tint(Color.blue)
                .scaleEffect(x: 1, y: 1.5, anchor: .center)

            Text("\(Int((1 - viewModel.currentUser.progressToNextLevel) * 1000)) XP to next level")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Color.secondary)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white.opacity(0.95))
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 10)
        )
    }

    private var topThreeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Top Learners")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)

            HStack(alignment: .bottom, spacing: 12) {
                if viewModel.topThree.count > 1 {
                    podiumCard(for: viewModel.topThree[1], place: .second)
                }

                if !viewModel.topThree.isEmpty {
                    podiumCard(for: viewModel.topThree[0], place: .first)
                }

                if viewModel.topThree.count > 2 {
                    podiumCard(for: viewModel.topThree[2], place: .third)
                }
            }
        }
    }

    private var rankingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Rankings")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)

            VStack(spacing: 12) {
                ForEach(viewModel.remainingRankings) { entry in
                    rankingRow(entry: entry)
                }
            }
        }
    }

    private func leaderboardMetric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.secondary)

            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)
        }
    }

    private func podiumCard(for entry: LeaderboardViewModel.RankedEntry, place: PodiumPlace) -> some View {
        VStack(spacing: 12) {
            Text("#\(entry.rank)")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(place.accentColor)

            Text(entry.user.username)
                .font(.system(size: place == .first ? 18 : 16, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)
                .multilineTextAlignment(.center)

            Text("\(entry.user.xp) XP")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.secondary)

            ProgressView(value: entry.user.progressToNextLevel)
                .progressViewStyle(.linear)
                .tint(place.accentColor)
                .scaleEffect(x: 1, y: 1.25, anchor: .center)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity)
        .frame(height: place.height)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(place.fill)
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 10)
        )
    }

    private func rankingRow(entry: LeaderboardViewModel.RankedEntry) -> some View {
        HStack(spacing: 14) {
            Text("#\(entry.rank)")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(Color.blue)
                .frame(width: 36, alignment: .leading)

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.user.username)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.primary)

                Text("Level \(entry.user.level)")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.secondary)
            }

            Spacer()

            Text("\(entry.user.xp) XP")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.white.opacity(0.95))
                .shadow(color: Color.black.opacity(0.04), radius: 14, x: 0, y: 8)
        )
    }

    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.99, green: 1.0, blue: 1.0),
                Color(red: 0.95, green: 0.98, blue: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

private enum PodiumPlace {
    case first
    case second
    case third

    var accentColor: Color {
        switch self {
        case .first:
            return Color(red: 0.91, green: 0.69, blue: 0.16)
        case .second:
            return Color(red: 0.45, green: 0.52, blue: 0.63)
        case .third:
            return Color(red: 0.76, green: 0.49, blue: 0.28)
        }
    }

    var fill: LinearGradient {
        switch self {
        case .first:
            return LinearGradient(
                colors: [Color(red: 1.0, green: 0.97, blue: 0.84), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
        case .second:
            return LinearGradient(
                colors: [Color(red: 0.94, green: 0.96, blue: 0.99), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
        case .third:
            return LinearGradient(
                colors: [Color(red: 0.99, green: 0.93, blue: 0.88), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    var height: CGFloat {
        switch self {
        case .first:
            return 212
        case .second:
            return 184
        case .third:
            return 170
        }
    }
}

#Preview {
    LeaderboardView()
}
