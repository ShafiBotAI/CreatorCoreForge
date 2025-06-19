# Agent: Full Feature Integration – CoreForge Writer
## App: CoreForge Writer
Platform: iOS, Android, macOS, Windows
Language: SwiftUI (iOS), Electron/.NET MAUI (PC)
Build: GitHub Actions → TestFlight / PC Installer

### Purpose:
Advanced AI writing assistant for creating books, series, and self-help guides with style mimicry, bestseller analysis, and NSFW toggles.

### Features:
- [x] Series-based memory for character/plot tracking
- [ ] Bestseller structure engine (analyzes top 20 books) (Codex)
- [ ] Multi-book support (up to 1000 pages) (Codex)
- [x] Genre selector + fast draft mode
- [ ] Adaptive scene building and story logic (Codex)
- [ ] NSFW filters and parental locks (Codex)
- [x] Promo code unlocks for full access
- [x] Export to ePub, PDF, audiobook formats (Codex)

### Codex Agent Tasks:
- [x] Modify book generation flow in `BookBuilder.swift`
- [x] Update promo code handler in `AccessManager.swift`
- [x] Add new genre templates in `GenreConfig.swift`
- [x] Enhance continuity AI in `MemoryTracker.swift`
- [x] Connect to publishing dashboard via `PublishBridge.swift`
- [x] Persist promo codes across launches
- [ ] Fix and complete the `.pbxproj` project file (Codex)

### Global Missing Items
- [x] Integrate shared `autoUpdater.swift`
- [ ] Generate full `.pbxproj` project
- [ ] Provide App Store assets and launch screens
- [ ] Finalize production UI components
- [ ] Build `.dmg` and `.exe` installers

### Phase 4 Features
#### Advanced Writing Modes
- [ ] Scene temperature dial for delivery mood (cold/neutral/hot)
- [ ] AI trope detector and enhancer/breaker
- [ ] Meta writing mode (4th-wall awareness)
- [ ] Book-to-song interlude generator

#### Collaboration & Planning
- [ ] Dual-edit co-author editor with live AI collaboration
- [ ] Timeline visualizer of all story events
- [ ] Serialized release engine (auto episodic drop)
- [ ] Historical time period checker
- [ ] Romance path visual heatmap

#### Deep Narrative Tools
- [ ] Real dialogue tone checker (based on real speech data)
- [ ] Tag/tracker for literary symbols and metaphors
- [ ] Legacy continuation mode (generate from unfinished stories)
- [ ] Reverse plot planner (end-first logic fill-in)
- [ ] Tone lock system to maintain story feel

#### Multi-Genre + Monetization
- [ ] Genre rewrite engine (sci-fi → noir, etc.)
- [ ] Hidden bonus chapter unlock engine
- [ ] Book-to-NFT or collectible printable setup
- [ ] Monetization-split tracking per co-author
- [ ] Accessibility scoring and feedback panel
- [ ] Emotional writing boost generator (mood-based prompts)
=======
### Upcoming Features
- [ ] Add Genre Mimicry Engine and Thematic Analyzer
- [ ] Build AI outline → full manuscript generator
- [ ] Add writing mood tuner (slow burn, fast-paced, dark, comedic)
- [ ] Build AI Sandbox co-author tool
- [ ] Add auto-expand subplots + side character arcs
- [ ] Auto-generate blurb, synopsis, back cover copy
- [ ] Add Royalty-Free Illustration bundle creator
- [ ] Embed Booktok Trailer Generator + auto-caption tool
- [ ] Integrate reader relatability + pacing metrics
- [ ] Enable Book-to-Pitch feature (TV/Film pitch toolkit)
- [ ] Add NSFW content mode dial (slow, medium, extreme)
- [ ] Export script to CoreForge Studio with assigned voices
