import SwiftUI

struct ProjectQuickActionsBar: View {
    var body: some View {
        HStack {
            Button("Duplicate") {}
            Button("Export") {}
            Button("Delete") {}
            Button("Open") {}
        }
    }
}

struct ProjectQuickActionsBar_Previews: PreviewProvider {
    static var previews: some View {
        ProjectQuickActionsBar()
    }
}
