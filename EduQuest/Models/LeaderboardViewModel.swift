//
//  LeaderboardViewModel.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import Foundation
import Combine

final class LeaderboardViewModel: ObservableObject {
    struct UserRank: Identifiable {
        let id = UUID()
        let username: String
        let xp: Int
        let level: Int
        let progressToNextLevel: Double
    }

    @Published private(set) var title = "Leaderboard"
    @Published private(set) var subtitle = "See how you rank against other learners"
    @Published private(set) var currentUsername = "Ahmad"
    @Published private(set) var rankedUsers: [UserRank] = [
        UserRank(username: "Mia", xp: 4820, level: 8, progressToNextLevel: 0.84),
        UserRank(username: "Noah", xp: 4510, level: 7, progressToNextLevel: 0.68),
        UserRank(username: "Zara", xp: 4335, level: 7, progressToNextLevel: 0.53),
        UserRank(username: "Ahmad", xp: 3890, level: 6, progressToNextLevel: 0.77),
        UserRank(username: "Leo", xp: 3620, level: 6, progressToNextLevel: 0.52),
        UserRank(username: "Emma", xp: 3410, level: 5, progressToNextLevel: 0.91),
        UserRank(username: "Ava", xp: 3195, level: 5, progressToNextLevel: 0.64),
        UserRank(username: "Omar", xp: 2860, level: 5, progressToNextLevel: 0.28),
        UserRank(username: "Lina", xp: 2640, level: 4, progressToNextLevel: 0.88)
    ]

    var currentUser: UserRank {
        rankedUsers.first(where: { $0.username == currentUsername }) ?? rankedUsers[0]
    }

    var currentUserRank: Int {
        rankedUsers.firstIndex(where: { $0.username == currentUsername }).map { $0 + 1 } ?? 1
    }

    var topThree: [RankedEntry] {
        Array(rankedUsers.prefix(3).enumerated()).map { index, user in
            RankedEntry(rank: index + 1, user: user)
        }
    }

    var remainingRankings: [RankedEntry] {
        Array(rankedUsers.dropFirst(3).enumerated()).map { index, user in
            RankedEntry(rank: index + 4, user: user)
        }
    }

    struct RankedEntry: Identifiable {
        let id = UUID()
        let rank: Int
        let user: UserRank
    }
}
