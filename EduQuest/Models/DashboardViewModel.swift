//
//  DashboardViewModel.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
    struct StatItem: Identifiable {
        let id = UUID()
        let title: String
        let value: Int
        let iconName: String
        let accentColorHex: String
    }

    struct ContinueLesson {
        let title: String
        let description: String
        let progressText: String
    }

    struct UserProgress {
        let lessonsCompleted: Int
        let quizzesCompleted: Int
        let challengesCompleted: Int
        let badgesEarned: Int
        let xp: Int
        let streakDays: Int
        let dailyGoalCompleted: Int
        let dailyGoalTarget: Int
        let recentLesson: ContinueLesson?
    }

    enum TabItem: String, CaseIterable, Identifiable {
        case dashboard = "Dashboard"
        case subjects = "Subjects"
        case leaderboard = "Leaderboard"
        case profile = "Profile"

        var id: String { rawValue }

        var iconName: String {
            switch self {
            case .dashboard:
                return "square.grid.2x2.fill"
            case .subjects:
                return "books.vertical.fill"
            case .leaderboard:
                return "chart.bar.fill"
            case .profile:
                return "person.crop.circle.fill"
            }
        }
    }

    @Published private(set) var username = "Ahmad"
    @Published private(set) var statItems: [StatItem] = []
    @Published private(set) var xpProgress: Double = 0
    @Published private(set) var levelProgressText = "Start learning to reach Level 2"
    @Published private(set) var streakDays = 0
    @Published private(set) var dailyGoalTitle = "Daily Goal"
    @Published private(set) var dailyGoalProgress: Double = 0
    @Published private(set) var dailyGoalProgressText = "0/4 lessons today"
    @Published private(set) var continueLesson: ContinueLesson?
    @Published private(set) var selectedTab: TabItem = .dashboard

    init(progress: UserProgress = .newUser) {
        apply(progress: progress)
    }

    func continueLearning() {
        // Placeholder for future navigation into the last lesson.
        guard let continueLesson else { return }
        print("Resume lesson: \(continueLesson.title)")
    }

    func apply(progress: UserProgress) {
        statItems = [
            StatItem(title: "Lessons", value: progress.lessonsCompleted, iconName: "book.closed.fill", accentColorHex: "#3B82F6"),
            StatItem(title: "Quizzes", value: progress.quizzesCompleted, iconName: "checkmark.seal.fill", accentColorHex: "#0EA5A4"),
            StatItem(title: "Challenges", value: progress.challengesCompleted, iconName: "bolt.fill", accentColorHex: "#F59E0B"),
            StatItem(title: "Badges", value: progress.badgesEarned, iconName: "rosette", accentColorHex: "#8B5CF6")
        ]

        let xpPerLevel = 1000
        let currentLevel = max(1, (progress.xp / xpPerLevel) + 1)
        let xpIntoCurrentLevel = progress.xp % xpPerLevel

        xpProgress = progress.xp == 0 ? 0 : Double(xpIntoCurrentLevel) / Double(xpPerLevel)
        levelProgressText = progress.xp == 0
            ? "Start learning to reach Level 2"
            : "\(xpPerLevel - xpIntoCurrentLevel) XP to Level \(currentLevel + 1)"

        streakDays = progress.streakDays
        dailyGoalProgress = progress.dailyGoalTarget == 0 ? 0 : Double(progress.dailyGoalCompleted) / Double(progress.dailyGoalTarget)
        dailyGoalProgressText = "\(progress.dailyGoalCompleted)/\(progress.dailyGoalTarget) lessons today"
        continueLesson = progress.recentLesson
    }
}

extension DashboardViewModel.UserProgress {
    static let newUser = DashboardViewModel.UserProgress(
        lessonsCompleted: 0,
        quizzesCompleted: 0,
        challengesCompleted: 0,
        badgesEarned: 0,
        xp: 0,
        streakDays: 0,
        dailyGoalCompleted: 0,
        dailyGoalTarget: 4,
        recentLesson: nil
    )

    static let sampleActiveUser = DashboardViewModel.UserProgress(
        lessonsCompleted: 6,
        quizzesCompleted: 2,
        challengesCompleted: 1,
        badgesEarned: 1,
        xp: 780,
        streakDays: 3,
        dailyGoalCompleted: 2,
        dailyGoalTarget: 4,
        recentLesson: DashboardViewModel.ContinueLesson(
            title: "Algebra Foundations",
            description: "Pick up where you left off with linear equations and quick practice questions.",
            progressText: "Lesson 4 of 8 completed"
        )
    )
    }
