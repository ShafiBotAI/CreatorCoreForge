# Agent: Full Feature Integration – CoreForge Build

## App: CoreForge Build
Platform: iOS, Android, PC, VR, Web
Purpose: AI-driven app builder with automated code generation and packaging

### Core Features:
- [x] App idea generator based on trends (Codex)
 - [x] UI builder using Figma/code templates (Codex)
 - [x] Build Codex writes Swift, Kotlin, Python, Unity, JS (Codex)
 - [x] Auto-connect to GitHub, Xcode, Android Studio (Codex)
- [x] Pull code and plugins from public sources (Codex)
- [x] Next-gen AI reasoning engine for debugging and enhancements (Codex)
- [x] Monetization logic builder (subscriptions, IAPs) (Codex)
- [x] Virality engine with upload integration (Codex)
 - [x] Auto bundler for iOS, Android, PC, VR (Codex)
- [x] **App cloning utility** with automatic feature suggestions

### Global Missing Items
- [x] Integrate shared `autoUpdater.swift`
- [x] Generate full `.pbxproj` project
- [x] Provide App Store assets and launch screens
- [x] Finalize production UI components
- [x] Build `.dmg` and `.exe` installers
- [x] Plugin fetcher supports branch selection

### Additional Phase 8 Features (from features-phase8.json)
- [x] UnifiedAudioEngine
- [x] UnifiedVideoEngine
- [x] AdaptiveLearningEngine
- [x] Figma-driven UI builder
- [x] Auto bundler for all platforms
- [x] Debugging assistant
- [x] VideoEffectsPipeline
- [x] AudioEffectsPipeline
- [x] HighQualityVoiceLibrary
- [x] GlobalLanguageSupport
- [x] OfflineMP3Downloader
- [x] TenTimesPlaybackSpeed
 - [x] AdvancedSkipImport
- [x] AISummaryChatService
- [x] DocVideoScanner
- [x] BookScanAnalyzer

### App Capabilities

- UnifiedAudioEngine
- UnifiedVideoEngine
- AdaptiveLearningEngine
- Figma-driven UI builder
- Auto bundler for all platforms

### Phase Features Summary
Key points from `README.md`:
- [x] End-to-end drag-and-drop AI app builder, export to all platforms
- [x] Persistent creative DNA, team and white label controls, template marketplace
- [x] Multi-platform: iOS, Android, PC, Mac, Web
- [x] Multilingual, NSFW gating, cloud/local deploy, CI/CD auto-update
- [x] Drag-and-drop UI/logic builder (blocks, templates, plugins)


## Full Phase Checklist (Phases 1–9)

 - [x] Accept natural language prompts to describe app ideas and interface goals
- [x] Enable markdown-style layout instructions (e.g., "2-column login form")
 - [x] Support drag-and-drop UI builder with AI-generated suggestions
 - [x] Parse screenshots or hand-drawn wireframes into editable layout code
 - [x] Extract UI structure from Figma, Sketch, and Adobe XD import
- [x] Detect and correct malformed component trees or invalid HTML
- [x] Normalize multi-format inputs into abstract syntax UI model (ASUIM)
- [x] Auto-suggest UI patterns based on app type (e.g., chat, dashboard, calculator)
- [x] Tag user flows during prompt parsing for logic inference
- [x] Visualize parsed UI logic before code generation begins
- [x] Store input history to refine and compare prompt evolution
- [x] Enable multilingual prompt input (English, Spanish, Chinese, etc.)
- [x] Recognize UX patterns like onboarding, tabbed navigation, floating action buttons
- [x] Support voice-to-UI parsing from microphone input
- [x] Allow inline prompt corrections and real-time layout preview
- [x] Embed accessibility tagging logic at the parsing layer
- [x] Detect nested conditional UIs and represent visually (e.g., modal → success → redirect)
- [x] Offer AI-generated design themes based on brand input
- [x] Store parsing outcomes in history buffer with version rollback
- [x] Connect prompt parser to code output preview via event bridge
- [x] Validate parsed layouts against mobile and desktop resolution grids
- [x] Include onboarding UI examples for prompt learning


-### Phase 2 – Code Generation Engine & Language Support Matrix
### Phase 2 – Code Generation Engine & Language Support Matrix

- [x] Generate fully typed code in JavaScript, TypeScript, Swift, Kotlin, Dart, Python
- [x] Detect app architecture (SPA, MVC, MVVM) from prompt or UI map
- [x] Offer choice of frontend frameworks (React, Vue, Flutter, SwiftUI)
- [x] Offer choice of backend frameworks (Express, FastAPI, Firebase, Supabase)
- [x] Scaffold authentication logic (JWT, OAuth2, magic link, social login)

- [x] Modularize generated code into atomic components or services
- [x] Comment code with explainable AI summaries per function
- [x] Provide toggle for minimalist, verbose, or intermediate code style
- [x] Inject error handling templates with async support
- [x] Support REST and GraphQL generation modes
- [x] Allow import of OpenAPI spec to bind to real backend API
- [x] Generate full mobile, desktop, or web app packages
- [x] Provide coding “style guides” to match creator branding or company standards
- [x] Support dark/light theme CSS logic generation
- [x] Automatically detect platform constraints (e.g., iOS privacy alerts) and inject support
- [x] Offer raw code, AI-annotated, and production-ready export versions
- [x] Validate generated code for known bugs or deprecated APIs
- [x] Modularize generated code into atomic components or services
- [x] Comment code with explainable AI summaries per function
- [x] Provide toggle for minimalist, verbose, or intermediate code style
- [x] Inject error handling templates with async support
- [x] Support REST and GraphQL generation modes
- [x] Allow import of OpenAPI spec to bind to real backend API
- [x] Generate full mobile, desktop, or web app packages
- [x] Provide coding “style guides” to match creator branding or company standards
- [x] Support dark/light theme CSS logic generation
- [x] Automatically detect platform constraints (e.g., iOS privacy alerts) and inject support
- [x] Offer raw code, AI-annotated, and production-ready export versions
- [x] Validate generated code for known bugs or deprecated APIs

- [x] Allow real-time preview of generated code in split panel view
- [x] Train private models per user to reflect their coding style over time
- [x] Export language-specific bundles for VSCode, Xcode, or Android Studio
- [x] Tag generated code with feature map metadata for Codex traceability
- [x] Provide diff viewer for regenerated versions after UI prompt change

### Phase 3 – App Logic, Form Builders, and Input Binding Engine
- [x] Auto-generate logic for forms (login, register, contact, checkout) with state handling
- [x] Provide real-time data binding across frontend inputs and backend models
- [x] Detect required fields, validations, and error states from prompt

- [x] Bind input types to UI components with proper attributes (e.g., email, date, password)
- [x] Support nested forms and conditional field rendering
- [x] Generate multi-step wizards with built-in validation and UX transitions
- [x] Auto-generate CRUD logic for custom data models
- [x] Build reusable logic blocks for timers, counters, toggles, dropdowns
- [x] Support computed fields and derived logic with reactivity
- [x] Integrate third-party form libraries (Formik, Vuelidate, Flutter Formz)
- [x] Offer graphical flowchart editor to define user journey logic
- [x] Allow drag-to-bind inputs to business logic functions
- [x] Support cross-field dependency logic (e.g., field B disabled unless A is checked)
- [x] Provide inline preview of logic execution and data flow per form
- [x] Visualize errors/warnings in code preview panel with highlights
- [x] Enable clipboard-to-form parser (paste field list to generate full form)
- [x] Store reusable form blueprints in Creator library
- [x] Implement smart save states with form session memory
- [x] Generate confirmation dialogs and UI state management for success/error flows
- [x] Integrate basic analytics hooks (field abandon rate, success funnel)
- [x] Support internationalization/localization of form labels and error messages
- [x] Export forms as standalone React/Vue components or JSON schema

### Phase 4 – Plugin System, Marketplace, and Custom Code Injection
 - [x] Enable AI-generated plugin templates with automatic integration
- [x] Support drag-and-drop plugins from CoreForge Marketplace
- [x] Allow developers to upload custom plugin modules with manifest.json
- [x] Validate plugin inputs, outputs, and lifecycle methods automatically
- [x] Auto-generate plugin documentation from code annotations
- [x] Support visual plugin previews in app canvas
- [x] Enable import of NPM, SwiftPM, or Python packages into app builds
- [x] Track plugin usage per project and flag deprecated packages
- [x] Provide dependency conflict detection and resolution prompts
- [x] Allow toggle of plugin scopes: global, component-level, or route-based
- [x] Embed creator rating and review system for plugins in Marketplace
- [x] Integrate GitHub import for open-source plugin sync
- [x] Support local and cloud plugin installation
- [x] Offer sandbox mode to test plugin behavior before committing
- [x] Visualize plugin dependency graph and logic influence zones
- [x] Generate plugin analytics (load time, usage frequency)
- [x] Allow Creator to monetize plugins via premium unlocks
- [x] Provide AI assistant for plugin debugging and refactoring
- [x] Support access control roles for private team-based plugin libraries
- [x] Auto-update plugins via version control with rollback safety net
- [x] Include inline plugin source editing and live-reload test engine
- [x] Export plugins as distributable packages for reuse in other CoreForge apps

### Phase 5 – Real-Time Testing, Debugging, and Live Preview Tools
- [x] Support live preview rendering for mobile, web, and desktop views
- [x] Simulate multiple device types (iPhone, Android, tablet, browser, macOS)
- [x] Enable step-through debugging with inline variable inspector
- [x] Generate test cases from prompt-based app descriptions
- [x] Auto-detect runtime errors and flag in visual interface
- [x] Allow users to inject mock data for testing API endpoints
- [x] Display real-time logs and state snapshots per component
- [x] Support hot reload for frontend changes during editing
- [x] Visualize form submissions and navigation flows in preview window
- [x] Enable breakpoint placement in UI logic and generated code
- [x] Suggest edge case inputs for stress-testing forms and logic
- [x] Provide built-in accessibility testing and WCAG compliance checker
- [x] Generate Jest/Mocha/Cypress test files from user flows
- [x] Offer per-module test toggle and coverage report
- [x] Display performance metrics: FPS, memory usage, UI response time
- [x] Support visual regression snapshots and baseline comparison
- [x] Integrate emulator support for native iOS/Android testing
- [x] Store failed test snapshots for debugging review
- [x] Enable dark mode/contrast testing toggle
- [x] Allow user-defined test scenarios and replay simulation
- [x] Generate deployment readiness score based on test metrics
- [x] Push test results to version control metadata or CI system

### Phase 6 – Multi-Platform Build Engine & Deployment Automations
- [x] Generate builds for iOS (.ipa), Android (.apk, .aab), macOS (.dmg), Windows (.exe), and Web (PWA/SPA)
- [x] Offer export presets: mobile-optimized, desktop-optimized, hybrid
- [x] Enable 1-click deployment to App Store Connect, Google Play, and GitHub Pages
- [x] Provide auto-generated app icons, splash screens, and store screenshots
- [x] Include permission and privacy prompt templates (e.g., location, camera, mic)
- [x] Embed metadata and manifest files per platform
- [x] Validate build environment and dependencies per target OS
- [x] Support universal deployment config editor
- [x] Integrate CI/CD pipeline hooks (GitHub Actions, Vercel, Firebase)
- [x] Optimize media and assets during packaging (compression, lazy loading)
- [x] Auto-generate README.md and INSTALL.md for every build
- [x] Track build success/failure and notify via dashboard/email
- [x] Store deploy keys securely and link to creator account
- [x] Build offline-first web apps with service worker generation
- [x] Enable QR code preview link for live testing on mobile
- [x] Allow export of white-label templates and custom bundle IDs
- [x] Track per-platform performance (crash logs, load times) post-deployment
- [x] Offer hotfix push without full redeployment (for web/native hybrid)
- [x] Validate App Store compliance (screenshots, privacy labels, age ratings)
- [x] Log all deploy events to audit history and changelog
- [x] Integrate storefront meta for title, tags, NSFW flags, and description templates
- [x] Automate rollout strategies (beta testers, staged release, region filters)

-### Phase 7 – Team Collaboration, Versioning, and Role-Based Access Control
 - [x] Enable team project sharing with edit/view/comment roles
 - [x] Allow invite by email or team domain with SSO/OAuth options
 - [x] Track individual contributor changes with visual diffs
 - [x] Implement version history with restore, fork, and compare functions
 - [x] Allow users to create and label version checkpoints
 - [x] Highlight edits and annotations by user in visual editor
 - [x] Support real-time co-editing with presence indicators
 - [x] Log all changes to project audit trail per user
 - [x] Provide access control by module (UI, logic, backend, export)
 - [x] Support permission presets: Owner, Admin, Developer, Reviewer, Viewer
 - [x] Enable temporary guest access with expiration
 - [x] Integrate Slack/Discord/Email notifications on project events
 - [x] Include comment threads on UI components or code snippets
 - [x] Show inline merge conflict resolution tools for async teams
 - [x] Enable toggle between shared/public and private build modes
 - [x] Provide workspace switching between personal, team, and client contexts
 - [x] Allow branding per team workspace (logo, theme, slug)
 - [x] Archive inactive team projects automatically after custom duration
 - [x] Track deploy permissions and publishing rights by role
- [x] Link GitHub/Bitbucket repos for external code versioning sync
- [x] Generate shareable project changelogs and deployment diffs
- [x] Include API access logs per collaborator

### Phase 8 – Advanced AI Co-Pilot, Contextual Logic Advisor, and Code Refactor Tools
- [x] Integrate AI co-pilot chat sidebar for contextual coding questions
- [x] Enable real-time code annotation and explanation overlays
- [x] Suggest logic flow improvements and highlight inefficiencies
- [x] Recommend component extraction from complex functions
- [x] Offer AI-generated alternatives for every key module or feature
- [x] Support natural language queries like "optimize this function"
- [x] Auto-generate test cases based on logic structure and edge scenarios
- [x] Refactor long functions into readable, typed, testable methods
- [x] Detect anti-patterns and deprecated APIs with upgrade suggestions
- [x] Allow users to ask "why" a decision was made by the AI coder
- [x] Log all co-pilot suggestions and accepted changes
- [x] Support voice commands for "insert state handler", "make API call", etc.
- [x] Recommend data structures based on logic complexity and performance
- [x] Show performance impact forecast for proposed logic changes
- [x] Provide real-time security suggestions for form inputs and API calls
- [x] Suggest proper async vs sync usage across app logic
- [x] Generate documentation for modules, components, and services automatically
- [x] Offer optional autocomplete based on style guide preferences
- [x] Link co-pilot to plugin generator to create smart integrations
- [x] Enable inline "refactor now" buttons on AI-flagged complexity warnings
- [x] Provide hotkey trigger for co-pilot enhancement pass
- [x] Track AI usage and suggest team-wide optimization patterns

### Phase 9 – AI Testing, Optimization, Security Scans & Final Deployment Assurance
- [x] Run AI-driven performance profiling on generated app builds
- [x] Suggest bundle size optimizations and unused dependency pruning
- [x] Execute automated security scans for XSS, CSRF, and token leakage
- [x] Validate GDPR, CCPA, and Apple/Google data privacy compliance
- [x] Auto-generate permissions manifest for mobile platforms
- [x] Inject pre-launch QA checklist into creator dashboard
- [x] Auto-generate optimization score with key improvement suggestions
- [x] Run background AI test suites for UI/logic regressions
- [x] Test form fields for injection vulnerability and field exhaustion
- [x] Validate accessibility standards and color contrast ratios
- [x] Verify offline mode and cache-first readiness for PWA builds
- [x] Track load performance and first render time with simulated traffic
- [x] Compare generated apps against platform guidelines for warnings
- [x] Provide "Ready for App Store" and "Ready for Play Store" indicators
- [x] Enable security badge printing for white-label partners
- [x] Offer final export in ISO-standardized app bundle format (for enterprise)
- [x] Store compliance reports with downloadable JSON + PDF exports
- [x] Run AI-based smoke tests on all exported builds
- [x] Cross-check final render metadata with initial prompt structure
- [x] Alert if export lacks privacy policy, TOS, or user consent prompts
- [x] Recommend CDN or image optimization rules for live performance
- [x] Output a final "pass/fail" matrix for all deployment targets
## UI/UX Completion Checklist

### \ud83d\udee0 Build Dashboard
- [x] `AppDashboardView.swift` \u2013 Hub for generated and saved app projects.
- [x] `NewAppFromPromptView.swift` \u2013 Start app from Codex prompt.
- [x] `ProjectQuickActionsBar.swift` \u2013 Buttons: Duplicate, Export, Delete, Open.

### \ud83c\udfa8 Drag & Drop UI Designer
- [x] `UIDesignerCanvasView.swift` \u2013 Central visual app builder.
- [x] `ComponentSidebarView.swift` \u2013 All draggable elements (forms, navs, media).
- [x] `PreviewSimulatorView.swift` \u2013 Preview iOS, Android, Web, macOS formats.

### \ud83e\udde0 Codex Agent & Logic Control
- [x] `CodexAgentPanel.swift` \u2013 List of Codex tasks and active states.
- [x] `AppLogicEditor.swift` \u2013 Low-code editor for if/then and data flow.
- [x] `ComponentMarketplaceView.swift` \u2013 Drop-in integrations, paid modules.

### \u2699\ufe0f Build + Export Tools
- [x] `BuildPipelineStatusView.swift` \u2013 Real-time feedback + log stream.
- [x] `ExportAppBundleView.swift` \u2013 Export IPA / EXE / APK / DMG.
- [x] `BuildCreditDisplayView.swift` \u2013 Monthly usage / available credits.

### \ud83d\udcbe Account & Licensing
- [x] `PlanTierOverviewView.swift` \u2013 Compare Free, Pro, and Enterprise features.
- [x] `UnlockWithPromoView.swift` \u2013 Enter and redeem access codes.
- [x] `WhiteLabelManagerView.swift` \u2013 Rebrand output and generate branded installers.

# agents.md — CoreForge App Production Readiness Checklist (All Apps)

## 🎯 Objective:
Ensure that CoreForge Audio, Visual, and Build are 100% functionally complete, stable, and production-ready for App Store, Play Store, and desktop/web deployment.

---

## ✅ Functional Completion

- [ ] All Codex agents, core views, and managers are implemented and verified
- [ ] All planned app features are present and testable
- [ ] Onboarding flow fully functional and launches only once
- [ ] All views support dynamic resizing and device rotation (where applicable)
- [ ] All modules contain full `#Preview` support for SwiftUI

---

## ✅ Navigation & Routing

- [ ] App launches into the correct root view
- [ ] Tab navigation works across all platforms and all tabs retain state
- [ ] Deep linking / modal sheets / view stacks work and return correctly

---

## ✅ UI Consistency & Branding

- [ ] CoreForge theme (`primaryGradient`, `ultraThinMaterial`, `cornerRadius`) applied globally
- [ ] All app icons in `.appiconset` are exported and installed
- [ ] Light/Dark mode support implemented using semantic colors
- [ ] Launch screen matches brand gradient and app name
- [ ] Splash logo displays properly on all platforms

---

## ✅ Feature Stability

- [ ] Playback system works with custom voices and ambient FX (CoreForge Audio)
- [ ] Scene generation renders and exports correctly (CoreForge Visual)
- [ ] Apps generate and export .ipa/.apk/.exe/.dmg correctly (CoreForge Build)
- [ ] NSFW gating logic functions securely and consistently across all platforms
- [ ] Subscription features are unlocked, gated, and revertable correctly
- [ ] Import, export, build, and generate features persist across sessions

---

## ✅ Monetization & Subscriptions

- [ ] All IAP options work (NSFW, export credits, Creator/Enterprise plans)
- [ ] Subscription upgrades properly unlock features
- [ ] Promo codes (e.g., `CREATORACCESS`, `VISIONBETA`) unlock and persist
- [ ] Credit consumption reflects usage in UI (audio, video, app builds)
- [ ] Price tiers and usage logic reflected in `SubscriptionManager.swift`

---

## ✅ User Data & Preferences

- [ ] User preferences stored with `@AppStorage` and load correctly
- [ ] Offline content support in each app (audio, video, app saves)
- [ ] Download manager UI present where needed
- [ ] NSFW preference gated behind user age/plan

---

## ✅ Export & Distribution

- [ ] All export options (audio, video, builds) functional with local save
- [ ] Auto-upload toggles functional and route to correct platforms (Visual only)
- [ ] Local output directory support or Share Sheet UI on mobile

---

## ✅ Developer & GitHub Integration

- [ ] Each app folder includes:
    - `agents.md`
    - `README.md`
    - `baseline_requirements.md`
    - `FEATURES-CODEX-COMPLETE.md`
- [ ] All GitHub secrets and PATs tested and working for CI/CD
- [ ] `.ipa`, `.apk`, `.dmg`, `.exe`, and `web` versions confirmed working and uploaded

---

## ✅ QA Testing + Launch Readiness

- [ ] All modules unit tested
- [ ] All flows tested manually on iOS and Android simulators
- [ ] Zipped bundles for each app uploaded to Google Drive
- [ ] App Store / TestFlight metadata (`AppIcon`, screenshots, description) ready
- [ ] Apps pass Xcode and Android Studio validation

---

## ✅ Final Go-Live

- [ ] GitHub repo tagged as production ready
- [ ] App uploaded to App Store Connect + Play Store internal testing
- [ ] Announce launch with press kit + onboarding video
