import Foundation
import Combine

class FocusViewModel: ObservableObject {

    @Published var timeLeft: Int = 1500   // 初始时间：25分钟
    @Published var running = false
    var timer: Timer?

    func start() {
        running = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeLeft > 0 {
                self.timeLeft -= 1
            } else {
                self.stop()
                self.timeLeft = 1500  // 重置为25分钟
            }
        }
    }

    func stop() {
        running = false
        timer?.invalidate()
    }

    func reset() {
        timeLeft = 1500
        stop()
    }

    func formatTime() -> String {
        let minutes = timeLeft / 60
        let seconds = timeLeft % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
