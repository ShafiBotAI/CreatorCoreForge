import SwiftUI
import CreatorCoreForge

struct BuildQuotaMeterView: View {
    var used: Int
    var quota: Int

    private var percentage: Double {
        quota == 0 ? 0 : Double(used) / Double(quota)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Build Usage")
                .font(.headline)
            ProgressView(value: Double(used), total: Double(quota)) {
                Text("\(used)/\(quota)")
                    .font(.subheadline)
            }
            .progressViewStyle(.linear)
            .tint(AppTheme.accentColor)
            HStack {
                Spacer()
                Text(String(format: "%.0f%% used", percentage * 100))
                    .font(.caption)
                    .foregroundColor(AppTheme.secondaryColor)
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .background(AppTheme.primaryGradient.opacity(0.2))
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    BuildQuotaMeterView(used: 3, quota: 10)
}
