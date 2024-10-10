import AVFoundation

class SoundManager: ObservableObject {
    var player: AVAudioPlayer?

    func playSound() {
        if let url = Bundle.main.url(forResource: "notification", withExtension: "mp3") {
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
            } catch {
                print("Error playing sound.")
            }
        }
    }
}
