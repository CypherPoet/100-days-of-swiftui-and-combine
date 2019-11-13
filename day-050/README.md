# Day 50: _Project 10: CupcakeCorner_ (Part Two)

_Follow along at https://www.hackingwithswift.com/100/swiftui/50_.

<br/>


# 📒 Field Notes

This day covers Part Two of _`Project 10: CupcakeCorner`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/50). (Project 10 files can be found in the [directory for Part One](../day-049/).)

It focuses on several specific topics:

- Taking basic order details
- Checking for a valid address
- Preparing for checkout


I deviated somewhat from the instructions of the course, but this was a really valuable opportunity for experimenting with architecting and persisting form state across multiple views -- while also organizing nested navigation in a single "container view":

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
                                viewModel: CheckoutViewModel(order: self.orderFromFormData),
                                onSubmit: self.submitOrder(_:)
                            )
                        }
                    )
                }
            )
            .navigationBarTitle("🧁 Cupcake Corner")
        }
    }
}
```

The contents of each `buildDestination` closure could be pulled out if things got _too_ nested, but overall, this still feels like a clean way of decoupling each "child" view from the container's overarching routing logic.

<br/>


# 📸 Screenshots

<div style="text-align: center;">
  <img src="../day-049/Projects/CupcakeCorner/Screenshots/day-50-recording-1.gif" width="400px"/>
</div>
