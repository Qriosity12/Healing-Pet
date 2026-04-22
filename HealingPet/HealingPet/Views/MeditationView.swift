import SwiftUI
import AVFoundation

struct MeditationView: View {
    @State private var isMeditating = false
    @State private var meditationText = "请找到一个舒适的位置，闭上眼睛，慢慢深呼吸..."
    @State private var player: AVAudioPlayer?

    let meditationAudioFile = "meditation_guide"

    let meditationMessages = [
        "深吸气，放松你的肩膀...",
        "吐气，感受压力逐渐释放...",
        "继续深呼吸，注意每一个呼吸的节奏...",
        "放松你的身体，感受每个部位的轻松...",
        "现在请慢慢睁开眼睛，回到现实世界，感谢自己这段放松的时间。"
    ]
    
    func startMeditationAudio() {
        if let url = Bundle.main.url(forResource: meditationAudioFile, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("音频播放错误: \(error.localizedDescription)")
            }
        }
    }
    
    func playMeditationVoice() {
        startMeditationAudio()
        meditationText = meditationMessages[0]
    }

    var body: some View {
            ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.5), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

                GeometryReader { geometry in
                    VStack {
                        Text(meditationText)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(30)
                        .background(Color.black.opacity(0.35))
                            .cornerRadius(15)
                        .frame(maxWidth: geometry.size.width * 0.8)
                            .padding(.top, 100)
                        
                        Spacer()
                        
                        Button(action: {
                            if !isMeditating {
                                isMeditating = true
                            playMeditationVoice()
                            }
                        }) {
                            Text(isMeditating ? "冥想中..." : "开始冥想")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                                .padding(.bottom, 50)
                        }
                    }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
