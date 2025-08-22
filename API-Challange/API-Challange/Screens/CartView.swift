import SwiftUI
import SwiftData

struct CartView: View {
    
    @State var viewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Cart")
                .task {
                    await viewModel.loadCart()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .isLoading:
            ProgressView()
        case .error(let message):
            
            VStack(spacing: 12) {
                Text(message)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Tentar novamente") {
                    Task { await viewModel.loadCart() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case .loaded:
            
            VStack(spacing: 16) {
                ScrollView {
                    VStack (spacing: 16) {
                        ForEach(viewModel.cartDisplayItems) { item in
                            ProductListCart(
                                item: item,
                                onIncrease: { viewModel.increaseQuantity(for: item) },
                                onDecrease: { viewModel.decreaseQuantity(for: item) }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack {
                    HStack {
                        Text("Total:")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.labelsPrimary)
                        Spacer()
                        Text("US$ \(viewModel.totalPrice)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.labelsPrimary)
                    }
                    
                    Button {
                        print("Botão Checkout clicado!")
                    } label: {
                        Text("Checkout")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.labelsPrimary)
                            .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.fillsTertiary)
                            )
                    }
                }
                .padding([.horizontal, .bottom])
            }
            
        case .cartEmpty:
            EmptyState(style: .cart)
        }
    }
}

#Preview {

    TabBar()
}
