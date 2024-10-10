import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var workTimeRemaining = 1200
    @State private var restTimeRemaining = 0
    @State private var isWorkTimerRunning = false
    @State private var isRestTimerRunning = false
    @State private var isPaused = false
    @State private var coffeeFill: CGFloat = 0.0
    @State private var timer: Timer?

    @StateObject var soundManager = SoundManager()

    var body: some View {
        VStack {
            Text("20-20-20 Pomodoro Timer")
                .font(.largeTitle)
                .padding()

            Text(isRestTimerRunning ? "Rest Time" : "Work Time")
                .font(.headline)

            Text("\(timeString(time: isRestTimerRunning ? restTimeRemaining : workTimeRemaining))")
                .font(.system(size: 64))
                .padding()

            if !isRestTimerRunning {
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
            }

            HStack(spacing: 20) {
                if !isWorkTimerRunning && !isPaused && !isRestTimerRunning {
                    Button(action: {
                        self.startWorkTimer()
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

                if isWorkTimerRunning || isRestTimerRunning {
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

                if isPaused && !(isWorkTimerRunning || isRestTimerRunning) {
                    Button(action: {
                        self.resumeTimer()
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Resume")
                        }
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }

                if isWorkTimerRunning || isRestTimerRunning || isPaused {
                    Button(action: {
                        self.resetTimer()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
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

    func startWorkTimer() {
        self.isWorkTimerRunning = true
        self.isPaused = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.workTimeRemaining > 0 {
                self.workTimeRemaining -= 1
                self.updateCoffeeFill()
            } else {
                timer.invalidate()
                self.isWorkTimerRunning = false
                self.soundManager.playSound()
                self.startRestTimer()
            }
        }
    }

    func startRestTimer() {
        self.restTimeRemaining = Int.random(in: 60...300)
        self.isRestTimerRunning = true
        self.isPaused = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.restTimeRemaining > 0 {
                self.restTimeRemaining -= 1
            } else {
                timer.invalidate()
                self.isRestTimerRunning = false
                self.soundManager.playSound()
                self.resetTimer()
            }
        }
    }

    func pauseTimer() {
        self.isPaused = true
        self.isWorkTimerRunning = false
        self.isRestTimerRunning = false
        self.timer?.invalidate()
    }

    func resumeTimer() {
        self.isPaused = false
        if self.workTimeRemaining > 0 {
            self.startWorkTimer()
        } else if self.restTimeRemaining > 0 {
            self.startRestTimer()
        }
    }

    func resetTimer() {
        self.isWorkTimerRunning = false
        self.isRestTimerRunning = false
        self.isPaused = false
        self.timer?.invalidate()
        self.workTimeRemaining = 1200
        self.coffeeFill = 0.0
        self.restTimeRemaining = 0
    }

    func updateCoffeeFill() {
        withAnimation {
            let progress = CGFloat(1200 - workTimeRemaining) / 1200
            self.coffeeFill = progress
        }
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
