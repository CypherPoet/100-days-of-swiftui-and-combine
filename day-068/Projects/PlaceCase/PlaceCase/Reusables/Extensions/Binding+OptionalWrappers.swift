//
//  Binding+OptionalWrappers.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/13/19.
// ✌️
//

// Inspired by https://alanquatermain.me/programming/swiftui/2019-11-15-CoreData-and-bindings/


import SwiftUI

extension Binding {
    
    /// Given a binding to an optional value, creates a non-optional binding that projects
    /// the unwrapped value. If the given optional binding contains `nil`, then the supplied
    /// value is assigned to it before the projected binding is generated.
    ///
    /// This allows for one-line use of optional bindings, which is very useful for CoreData types
    /// which are non-optional in the model schema but which are still declared nullable and may
    /// be nil at runtime before an initial value has been set.
    ///
    ///     class Thing: NSManagedObject {
    ///         @NSManaged var name: String?
    ///     }
    ///     struct MyView: View {
    ///         @State var thing = Thing(name: "Bob")
    ///         var body: some View {
    ///             TextField("Name", text: Binding($thing.name, ""))
    ///         }
    ///     }
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure the source doesn't contain nil.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Now use the regular unwrapping initializer.
        self.init(source)!
    }

    /// Creates a binding that projects the result of `source.wrappedValue == nil`. Additionally
    /// takes a default value: this will be used to set the underlying binding's value when this binding's
    /// wrapped value is set to `true`.
    init<T>(isNotNil source: Binding<T?>, defaultValue: T) where Value == Bool {
        self.init(get: { source.wrappedValue != nil },
                  set: { source.wrappedValue = $0 ? defaultValue : nil })
    }
}

extension Binding where Value: Equatable {
    
    /// Creates a non-nil binding by projecting to its unwrapped value, translating nil values
    /// to or from the given nil value. If the source contains nil, this binding will return the
    /// nil value. If this binding is set to the given nil value, it will assign nil to the underlying
    /// source binding.
    ///
    /// This is useful if you have optional values of a type that has a logical 'empty' value of
    /// its own, for example `String`:
    ///
    ///     @State var name: String?
    ///     ...
    ///     TextField(text: Binding($name, replacingNilWith: ""))
    ///
    /// If the `name` property contains `nil`, the text field will see an empty string. If the text field
    /// assigns an empty string, the `name` property will be set to `nil`.
    init(_ source: Binding<Value?>, replacingNilWith nilValue: Value) {
        self.init(
            get: { source.wrappedValue ?? nilValue },
            set: { newValue in
                if newValue == nilValue {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
    }
}
