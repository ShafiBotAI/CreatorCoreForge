#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @AppStorage("selectedVoice") private var selectedVoice = "Default"
    @State private var volume: Double = 0.5
    @State private var fontSize: Double = 16
    @State private var saveOffline = false
    @AppStorage("darkMode") private var darkMode = false
    @State private var highAI = false
    @State private var showReader = false
    @State private var showPreviewAlert = false
    @State private var recordings: [String] = []
    @State private var showSettings = false
    @State private var showPlayer = false
    @State private var currentURL: URL?

    @StateObject private var downloadQueue = DownloadQueue()
    @StateObject private var vault = StealthVaultManager()

    @AppStorage("stealthMode") private var stealthMode = false
    @StateObject private var vault: StealthVaultManager
    @StateObject private var downloadQueue: DownloadQueue

    init() {
        let manager = StealthVaultManager()
        _vault = StateObject(wrappedValue: manager)
        _downloadQueue = StateObject(wrappedValue: DownloadQueue(vault: manager))
    }

    private let voices = VoiceConfig.voices.map { $0.name }
    private let voiceMapper = CharacterVoiceMapper()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextEditor(text: $text)
                    .font(.system(size: CGFloat(fontSize)))
                    .frame(height: 150)
                    .overlay(
                        Group {
                            if text.isEmpty {
                                Text("Enter text...")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 4)
                                    .padding(.top, 8)
                            }
                        }, alignment: .topLeading
                    )
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    .padding(.horizontal)

                Picker("Voice", selection: $selectedVoice) {
                    ForEach(voices, id: \.self) { voice in
                        Text(voice)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                Button("Preview Voice") {
                    previewVoice()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .alert("Preview not available", isPresented: $showPreviewAlert) {
                    Button("OK", role: .cancel) { }
                }

                Text("Current voice: \(selectedVoice)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)

                HStack {
                    Text("Volume")
                    Slider(value: $volume, in: 0...1)
                }
                .padding(.horizontal)

                HStack {
                    Text("Font Size")
                    Slider(value: $fontSize, in: 14...30, step: 1)
                }
                .padding(.horizontal)

                Toggle("Save to Offline Vault", isOn: $saveOffline)
                    .padding(.horizontal)
                Toggle("Dark Mode", isOn: $darkMode)
                    .padding(.horizontal)
                Toggle("AI Boost", isOn: $highAI)
                    .padding(.horizontal)
                if !recordings.isEmpty && !stealthMode {
                    List(recordings, id: \.self) { rec in
                        Text(rec).lineLimit(1)
                    }
                    .frame(height: 100)
                }
                if downloadQueue.progress > 0 && downloadQueue.progress < 1 {
                    ProgressView(value: downloadQueue.progress)
                        .padding(.horizontal)
                }


                HStack {
                    Button(action: uploadAudio) {
                        Label("Upload", systemImage: "icloud.and.arrow.up")
                    }
                    Button(action: { showReader.toggle() }) {
                        Label("Reader", systemImage: "book")
                    }
                }
                .padding(.top, 10)
            }
            .navigationTitle("VocalVerse")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: playAudio) {
                        Label("Play", systemImage: "play.fill")
                    }
                    Button(action: { text = "" }) {
                        Label("Clear", systemImage: "trash")
                    }
                    Button(action: { showSettings.toggle() }) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
        .onAppear {
            vault.setStealthMode(stealthMode)
            recordings = vault.listFiles()
        }
        .onChange(of: stealthMode) { newValue in
            vault.setStealthMode(newValue)
            recordings = vault.listFiles()
        }
        .sheet(isPresented: $showReader) {
            ReaderView(text: text, fontSize: $fontSize, isPresented: $showReader)
        }
        .sheet(isPresented: $showPlayer) {
            if let url = currentURL {
                AudiobookPlayerView(url: url)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .onAppear { vault.setStealthMode(stealthMode) }
        .onChange(of: stealthMode) { vault.setStealthMode($0) }
    }

    private func playAudio() {
        // Map character voices from the current text
        let mappings = voiceMapper.assignVoices(to: text)
        for map in mappings {
            VoiceConfig.addVoice(id: map.assignedVoice.lowercased(), name: map.assignedVoice)
            let voice = Voice(id: map.assignedVoice.lowercased(), name: map.assignedVoice)
            CharacterVoiceMemory.shared.assignVoice(voice, to: map.name)
        }

        // Open the first recording in the vault when available
        if let first = recordings.first,
           let url = vault.retrieve(named: first) {
            currentURL = url
            showPlayer = true
        }
        VoiceHistory.shared.record(voice: selectedVoice)
    }

    private func previewVoice() {
        // Placeholder for voice preview implementation
        VoiceHistory.shared.record(voice: selectedVoice)
        showPreviewAlert = true
    }

    private func uploadAudio() {
        // Placeholder for auto upload implementation
        if saveOffline {
            if let url = URL(string: "https://example.com/\(UUID().uuidString).mp3") {
                downloadQueue.enqueue(url, voice: selectedVoice) { local in
                    try? vault.store(url: local, named: local.lastPathComponent)
                    recordings = vault.listFiles()
                }
                downloadQueue.start()
            }
        }
        // When implemented, this will send the recorded audio to cloud storage
    }
}

struct ReaderView: View {
    let text: String
    @Binding var fontSize: Double
    @Binding var isPresented: Bool
    @State private var lineSpacing: Double = 2.0

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text(text.isEmpty ? "No text" : text)
                        .font(.system(size: CGFloat(fontSize)))
                        .lineSpacing(lineSpacing)
                        .padding()
                }
                Slider(value: $fontSize, in: 14...30, step: 1)
                    .padding()
                Slider(value: $lineSpacing, in: 0...10, step: 0.5)
                    .padding()
            }
            .navigationTitle("Reader")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { isPresented = false }
                }
            }
        }
    }
}
#else
struct ContentView {}
#endif
