import SwiftUI

struct FocusView: View {
    @StateObject var vm = FocusViewModel()
    
    let petImages = ["pet_happy", "pet_neutral", "pet_happy", "pet_neutral"]

    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 30) {
                    Text(vm.formatTime())
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Button(vm.running ? "停止" : "开始") {
                        if vm.running {
                            vm.stop()
                        } else {
                            vm.start()
                        }
                    }
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(width: 180, height: 180)
                    .background(vm.running ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                }
                
                Image(petImages[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .offset(x: -110, y: -240)
                
                Image(petImages[1])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .offset(x: 110, y: -240)
                
                Image(petImages[2])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .offset(x: -110, y: 240)
                
                Image(petImages[3])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .offset(x: 110, y: 240)
            }
            .frame(height: 500)

            if !vm.running && vm.timeLeft == 0 {
                Text("很好，休息一下吧！")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }
}
