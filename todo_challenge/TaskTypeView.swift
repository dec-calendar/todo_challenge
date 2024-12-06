//
//  TaskTypeView.swift
//  todo_challenge
//
//  Created by 大澤清乃 on 2024/12/06.
//

import SwiftUI

struct TaskTypeView: View {
    @Binding var selectedTask: TaskType?
    var body: some View {
        VStack {
            HStack {
                TaskTypeButton(title: "ToDo", task: .todo, selectedTask: $selectedTask)
                Spacer()
                TaskTypeButton(title: "In Progress", task: .inProgress, selectedTask: $selectedTask)
                Spacer()
                TaskTypeButton(title: "Done", task: .done, selectedTask: $selectedTask)
            }
            .padding(.horizontal, 19)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .frame(width: selectedTask?.capsuleWidth, height: 55)
                    .foregroundStyle(.gray.opacity(0.3))
                    .alignmentGuide(.leading) {_ in 0}
                    .frame(maxWidth: .infinity, alignment: selectedTask?.aligment ?? .center)
            )
            .animation(.easeInOut(duration: 0.3), value: selectedTask)
        }
    }
}

struct TaskTypeButton: View {
    var title: String
    var task: TaskType
    @Binding var selectedTask: TaskType?
    var body: some View {
        Text(title).bold()
            .foregroundStyle(selectedTask == task ? Color.primary : .gray)
            .onTapGesture {
                selectedTask = task
            }
    }
}

#Preview {
    TaskTypeView(selectedTask: .constant(.done))
}

enum TaskType {
    case todo
    case inProgress
    case done
    
    var aligment: Alignment {
        switch self {
        case .todo:
            return .leading
        case .inProgress:
            return .center
        case .done:
            return .trailing
        }
    }
    
    var capsuleWidth: CGFloat {
        switch self {
        case .todo:
            return 80
        case .inProgress:
            return 120
        case .done:
            return 80
        }
    }
}
