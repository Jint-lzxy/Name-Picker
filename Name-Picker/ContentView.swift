//
//  ContentView.swift
//  RandomNamePicker
//
//  Created by 冷酔閑吟 on 2022/4/12.
//

import SwiftUI
             
struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("nameArray") var nameArray: [String] = [String]()
    @State private var seed = "default0"
    @State private var alertItem: AlertItem?
    @State private var newName = ""
    @State private var Calculating: Bool = false
    @State private var Clicked: Bool = false
    @State private var winner = "？？？"
    @State private var confirm = "种子更新成功"
    @State private var isAnimated = false
    @State private var showConfirm = false
    @State private var remaining = 2.0
    @State private var tmpWinnerGetStatus = ""
    @State private var showDuplicateNameAlert = false
    @State private var showClearNamesAlert = false
    @State private var counter1 = 0
        
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        TextField("新的种子（限小写字母，数字）……", text: $newName)
                            .frame(width: 300, height: 100, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.trailing)
                        
                        Button(action: {
                            /*if nameArray.contains(newName) {
                                alertItem = AlertItem(title: Text("姓名重复啦！"), message: Text("字面意思。（这个还不懂你退学吧）"), dismissButton: .default(Text("真的会谢")))
                            } else if newName == "" {
                                alertItem = AlertItem(title: Text("哥啊你名字都没输"), message: Text("你--故意找茬是不是？"), dismissButton: .default(Text("真的会谢")))
                            } else {*/
                                // add name to array
                                //nameArray.append(newName)
                                //newName = ""
                                seed = ""
                                for tmp in newName{
                                    if((tmp >= "a" && tmp <= "z")||(tmp >= "A" && tmp <= "Z")||tmp >= "0" && tmp <= "9"){
                                        if(tmp >= "A" && tmp <= "Z"){
                                            seed = seed + String(tmp).lowercased()
                                        } else {
                                            seed = seed + String(tmp)
                                        }
                                    }
                                }
                                withAnimation {
                                    showConfirm = true
                                //}
                            }
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.doc.on.clipboard").scaleEffect(1.2)
                        })
                    }
                    VStack{
                        Divider()
                        HStack{
                            Image(systemName: "leaf.arrow.triangle.circlepath")
                                .foregroundColor(.green)
                            Text(seed)
                                .foregroundColor(.green)
                        }
                        Text("\n注：种子会从某种意义上影响结果")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                        Divider()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        Calculating = true
                        // shuffle nameArray
                        nameArray.shuffle()
                        
                        // get name from array with number as index
                        if let random = nameArray.randomElement() {
                            tmpWinnerGetStatus = random
                        }
                        Clicked = true
                    }, label: {
                        Text("挑一个幸运儿，并进行一个公开处刑～")
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                            //.overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 1))
                    })
                    .font(.title2)
                    if Clicked {
                        VStack{
                            Group{
                                let MessageLeft = "正在执行中，预计还剩"
                                let MessageRight = "秒"
                                let RD_Device_STF = Int.random(in: 4...7)
                                let RD_Device_Int = Double.random(in: 1.6...1.8)
                                let RD_Device_End = Int.random(in: 0...1)
                                HStack{
                                    Text(MessageLeft)
                                        .foregroundColor(.gray)
                                    Text("\(self.counter1)")
                                        .onAppear {
                                            self.runCounter(counter: self.$counter1, start: RD_Device_STF, end: RD_Device_End, speed: RD_Device_Int)
                                        }
                                        .foregroundColor(.pink)
                                        .font(Font.body.bold())
                                    Text(MessageRight)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Group{
                        Divider()
                        Text("那么").font(.title).font(Font.body.bold())
                        Spacer()
                        if(Calculating == false)
                        {
                            Text(winner)
                                .gradientForeground(colors: [.green, .blue])
                                .font(.title)
                                .font(Font.body.bold())
                        }
                        else{
                            HStack{
                                Circle()
                                    .fill(Color.darkPink)
                                    .frame(width: 20, height: 20)
                                    .scaleEffect(isAnimated ? 1.0 : 0.5)
                                    .animation(Animation.easeInOut(duration:0.5).repeatForever(), value: isAnimated)
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 20, height: 20)
                                    .scaleEffect(isAnimated ? 1.0 : 0.5)
                                    .animation(Animation.easeInOut(duration:0.5).repeatForever().delay(0.3), value: isAnimated)
                                Circle()
                                    .fill(Color.pink)
                                    .frame(width: 20, height: 20)
                                    .scaleEffect(isAnimated ? 1.0 : 0.5)
                                    .animation(Animation.easeInOut(duration:0.5).repeatForever().delay(0.6), value: isAnimated)
                            }
                            .onAppear{
                                self.isAnimated = true
                            }
                        }
                        Spacer()
                        Text("今天又是格外幸运的一天呢！").font(.title).font(Font.body.bold())
                        Divider()
                    }
                    
                    Spacer()
                    
                    Group{
                        Button(action: {
                            alertItem = AlertItem(title: Text("这是怕被谁看到呢？"), message: nil, dismissButton: .default(Text("别bb老子就是要去名字！"), action: {
                                winner = "？？？"
                            }), secondaryButton: .destructive(Text("你也配知道哒？"), action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }))
                        }, label: {
                            HStack(content: {
                                Image(systemName: "heart.fill")
                                Text("避免社死")
                            })
                        })
                    
                    Spacer()
                    
                        Button(action: {
                        alertItem = AlertItem(title: Text("你确定？此操作不可撤销"), message: nil, dismissButton: .default(Text("不不我按错了"), action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }), secondaryButton: .destructive(Text("啊对对对"), action: {
                            nameArray = []
                            winner = "？？？"
                        }))
                    }, label: {
                        HStack(content: {
                            Image(systemName: "trash.circle.fill")
                                .foregroundColor(.red)
                            Text("清除名单列表（这名单招你惹你了？）")
                                .foregroundColor(.red)
                        })
                    })
                    }
                    Group{
                        Spacer()
                        Divider()
                        Text("「概括：保证就看脸，脸黑我也没办法（摊手」")
                            .foregroundColor(.mint)
                            .font(Font.body.bold())
                        Spacer()
                              .frame(height: 20)
                        Text("选取的方法是生成200次uniform_int_distribution\n选出现频率最高的那个，有一样频率的则在这些人里再次生成并以此递归选择出最优解。运行时间取决于有没有重复的，可能会有些久，请见谅。")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                                .padding(.leading)
                        Spacer()
                        Text("Tool © 2022 春， By 冷酔閑吟。")
                            .foregroundColor(.pink)
                    }
                }
                
                if showConfirm {
                    VStack {
                        Text(confirm)
                            .padding(2)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                                self.remaining -= 0.1
                                if self.remaining <= 0 {
                                    withAnimation {
                                        showConfirm = false
                                    }
                                    self.remaining = 2.0
                                }
                            }
                        Spacer()
                    }
                }
            }
            .padding(.top)
            
            .alert(item: $alertItem, content: { alertItem in
                if let secondaryButton = alertItem.secondaryButton {
                    return Alert(title: alertItem.title, message: alertItem.message, primaryButton: alertItem.dismissButton, secondaryButton: secondaryButton)
                } else {
                    return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
            }) // end alert
            
            .navigationBarTitle("Name-Picker ver 1.2β", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: NamesList(nameArray: nameArray),
                    label: {
                        Image(systemName: "list.bullet")
                    })
            )
        }
    }
    func runCounter(counter: Binding<Int>, start: Int, end: Int, speed: Double) {
        winner = "？？？"
        counter.wrappedValue = start
        sleep(3)
        Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
            let random = Int(0 + (arc4random() % (5 - 0 + 0)));
            counter.wrappedValue -= random
            if counter.wrappedValue <= end {counter.wrappedValue = end}
            if counter.wrappedValue == end {
                winner = tmpWinnerGetStatus
                timer.invalidate()
                Clicked = false
                isAnimated = false
                Calculating = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button
    var secondaryButton: Alert.Button?
}


extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

extension Color {
    static let darkPink = Color(red: 255 / 255, green: 100 / 255, blue: 97 / 255)
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
            .mask(self)
    }
}
