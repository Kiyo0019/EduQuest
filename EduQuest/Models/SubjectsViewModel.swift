//
//  SubjectsViewModel.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import Foundation
import Combine

final class SubjectsViewModel: ObservableObject {
    struct Subject: Identifiable, Hashable {
        let id: String
        let title: String
        let iconName: String
        let description: String
        let summary: String
        let accentColorHex: String
    }

    @Published private(set) var title = "Subjects"
    @Published private(set) var subtitle = "Choose a subject to start learning"
    @Published private(set) var subjects: [Subject] = [
        Subject(
            id: "programming",
            title: "Programming",
            iconName: "laptopcomputer",
            description: "Learn to code and build real projects",
            summary: "3 lessons, 1 quiz, 1 challenge",
            accentColorHex: "#3B82F6"
        ),
        Subject(
            id: "economics",
            title: "Economics",
            iconName: "chart.line.uptrend.xyaxis",
            description: "Understand money, markets, and smart decisions",
            summary: "3 lessons, 1 quiz, 1 challenge",
            accentColorHex: "#10B981"
        ),
        Subject(
            id: "social-skills",
            title: "Social Skills",
            iconName: "person.2.fill",
            description: "Improve communication, confidence, and interaction",
            summary: "3 lessons, 1 quiz, 1 challenge",
            accentColorHex: "#F59E0B"
        ),
        Subject(
            id: "mathematics",
            title: "Mathematics",
            iconName: "function",
            description: "Build problem-solving and logical thinking skills",
            summary: "3 lessons, 1 quiz, 1 challenge",
            accentColorHex: "#8B5CF6"
        )
    ]

    func makeDetailViewModel(for subject: Subject) -> SubjectDetailViewModel {
        SubjectDetailViewModel(subject: subject)
    }
}
