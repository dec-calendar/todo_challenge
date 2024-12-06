//
//  TaskRow.swift
//  todo_challenge
//
//  Created by 大澤清乃 on 2024/12/06.
//

import SwiftUI

struct TaskRow: View {
    @Binding var task: Task
    @State private var tapCount = 0
    @State private var tapTimer: Timer?
    var body: some View {
        HStack {
            Text(task.title)
                .padding()
            Spacer()
            Image(systemName: iconForStatus(task.status))
                .frame(width: 20, height: 20)
                .contentTransition(.symbolEffect)
        }
        .padding(.horizontal)
        .background(Color(.systemGray5))
        //        .overlay(alignment: .leading) {
        //
        //        }
        .clipShape(.rect(cornerRadius: 10))
        .contentShape(Rectangle())
        .onTapGesture {
            tapCount += 1
            tapTimer?.invalidate()
            tapTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) {_ in
                if tapCount == 1 {
                    withAnimation {
                        cycleTaskStatus()
                    }
                } else if tapCount == 2 {
                    withAnimation {
                        task.status = .done
                    }
                } else {
                    tapCount = 0
                }
            }
        }
    }
    
    private func colorForStatus(_ status: TaskType) -> Color {
        switch status {
        case .todo:
            return Color.gray.opacity(0.3)
        case .inProgress:
            return Color.yellow
        case .done:
            return Color.blue
        }
    }
    private func iconForStatus(_ status: TaskType) -> String {
        switch status {
        case .todo:
            return "zzz"
        case .inProgress:
            return "hourglass"
        case .done:
            return "checkmark"
        }
    }
    private func cycleTaskStatus() {
        switch task.status {
        case .todo:
            task.status = .inProgress
        case .inProgress:
            task.status = .todo
        case .done:
            task.status = .todo
        }
    }
}

#Preview {
    ContentView()
}
