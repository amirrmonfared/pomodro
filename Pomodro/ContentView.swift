import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 1200 // 20 minutes = 1200 seconds
    @State private var isTimerRunning = false
    @State private var isPaused = false
    @State private var coffeeFill: CGFloat = 0.0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("20-20-20 Pomodoro Timer")
                .font(.largeTitle)
                .padding()

            Text("\(timeString(time: timeRemaining))")
                .font(.system(size: 64))
                .padding()

            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 100, height: 300)
                    .foregroundColor(.gray.opacity(0.3))

                Rectangle()
                    .frame(width: 100, height: coffeeFill * 300)
                    .foregroundColor(.brown)
                    .animation(.easeInOut, value: coffeeFill)
            }
            .padding()

            HStack(spacing: 20) {
                if !isTimerRunning && !isPaused {
                    Button(action: {
                        self.startTimer()
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Start")
                        }
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }

                if isTimerRunning {
                    Button(action: {
                        self.pauseTimer()
                    }) {
                        HStack {
                            Image(systemName: "pause.fill")
                            Text("Stop")
                        }
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }

                if isPaused && !isTimerRunning {
                    Button(action: {
                        self.resumeTimer()
                    }) {
                        HStack {
                            Image(systemName: "play.fill") // Resume icon
                            Text("Resume")
                        }
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }

                if isTimerRunning || isPaused {
                    Button(action: {
                        self.resetTimer()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise") // Reset icon
                            Text("Reset")
                        }
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }
            }
            .padding()
        }
    }

    func startTimer() {
        self.isTimerRunning = true
        self.isPaused = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.updateCoffeeFill()
            } else {
                timer.invalidate()
                self.isTimerRunning = false
            }
        }
    }

    func pauseTimer() {
        self.isPaused = true
        self.isTimerRunning = false
        self.timer?.invalidate()
    }

    // Resume Timer Function
    func resumeTimer() {
        self.isPaused = false
        self.isTimerRunning = true
        self.startTimer()
    }

    // Reset Timer Function
    func resetTimer() {
        self.isTimerRunning = false
        self.isPaused = false
        self.timer?.invalidate()
        self.timeRemaining = 1200
        self.coffeeFill = 0.0
    }

    // Update Coffee Fill Animation
    func updateCoffeeFill() {
        withAnimation {
            let progress = CGFloat(1200 - timeRemaining) / 1200
            self.coffeeFill = progress
        }
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
