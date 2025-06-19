import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftUI)
struct ContentView: View {
    @State private var selectedStyle = RenderConfig.presets.first ?? "Default"
    @State private var nsfwEnabled = false
    @State private var generateRecap = false
    @State private var autoUpload = false
    @State private var language = LangSelector.enabledLanguages.first ?? "English"
    @State private var title = ""
    @State private var duration: Double = 5
    @State private var age: Double = 18

    @StateObject private var credits = CreditEngine.shared
    private let nsfwManager = NSFWPermissionManager()

    init() {
        // Enable all languages at launch
        LangSelector.enableMultiLanguage()
    }

    var body: some View {
        Form {
            Section(header: Text("Project")) {
                TextField("Project Title", text: $title)
                HStack {
                    Text("Age: \(Int(age))")
                    Slider(value: $age, in: 13...80, step: 1)
                }
            }

            Section(header: Text("Rendering")) {
                Picker("Style", selection: $selectedStyle) {
                    ForEach(RenderConfig.presets, id: \.self) { style in
                        Text(style)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                HStack {
                    Text("Duration: \(Int(duration))s")
                    Slider(value: $duration, in: 1...10, step: 1)
                }
                Toggle("NSFW", isOn: $nsfwEnabled)
            }

            Section(header: Text("Options")) {
                Toggle("Generate Recap", isOn: $generateRecap)
                Toggle("Auto Upload", isOn: $autoUpload)
                Picker("Language", selection: $language) {
                    ForEach(LangSelector.enabledLanguages, id: \.self) { lang in
                        Text(lang)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Text("Credits: \(credits.credits)")
            }

            Section {
                Button("Render") { startRender() }
            }
        }
    }

    private func startRender() {
        guard nsfwManager.canRenderNSFW(age: Int(age)) || !nsfwEnabled else {
            print("NSFW content blocked")
            return
        }
        guard credits.charge(Int(duration)) else {
            print("Not enough credits")
            return
        }
        // Placeholder for render action
        print("Rendering \(title) in style \(selectedStyle)")
        if autoUpload {
            print("Auto upload enabled")
        }
    }
}
#else
struct ContentView {}
#endif
