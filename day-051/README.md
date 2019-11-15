# Day 51: _Project 10: CupcakeCorner_ (Part Three)

_Follow along at https://www.hackingwithswift.com/100/swiftui/51_.

<br/>


# 📒 Field Notes

This day covers Part Three of _`Project 10: CupcakeCorner`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/51). (Project 10 files can be found in the [directory for Part One](../day-049/).)

It focuses on several specific topics:

- Encoding an ObservableObject class
- Sending and receiving orders over the internet


I took the opportunity with this day to explore how I could fit async networking side effects into a redux/reducer architecture.

Ultimately, this led to creating another view model `ObservableObject` for the container view -- which handled tapping in to the app state and detecting whether or not an alert should be shown.


```swift

final class OrderFormContainerViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    var store: AppStore


    // MARK: - Published Properties
    @Published var isShowingAlert = false


    // MARK: - Init
    init(store: AppStore) {
        self.store = store

        setupSubscribers()
    }
}


// MARK: - Publishers
extension OrderFormContainerViewModel {

    // 🔑 Tap into the store's `state` publisher.
    private var ordersStatePublisher: AnyPublisher<OrdersState, Never> {
        store.$state
            .map(\.ordersState)
            .eraseToAnyPublisher()
    }


    ... <<More publishers composed from here>> ...

```


```swift
// MARK: - Body
extension OrderFormContainerView {

    var body: some View {
        NavigationView {
            OrderFormView(
                viewModel: orderFormViewModel,
                buildDestination: {
                    DeliveryAddressFormView(
                        viewModel: self.deliveryAddressViewModel,
                        buildDestination: {
                            CheckoutView(
                                viewModel: CheckoutViewModel(
                                    order: self.orderFromFormData
                                ),
                                onSubmit: self.submitOrder(_:)
                            )
                        }
                    )
                }
            )
            .navigationBarTitle("🧁 Cupcake Corner")
            .alert(isPresented: $viewModel.isShowingSaveConfirmationAlert, content: { self.saveConfirmationAlert })
            .alert(isPresented: $viewModel.isShowingSaveErrorAlert, content: { self.saveErrorAlert })
        }
    }
}

```


<br/>



# 📸 Screenshots


<div style="text-align: center;">
  <img src="../day-049/Projects/CupcakeCorner/Screenshots/day-51-recording-1.gif" width="400px"/>
</div>
