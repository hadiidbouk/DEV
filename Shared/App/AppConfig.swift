//
//  AppConfig.swift
//  DEV (iOS)
//
//  Created by Hadi on 23/03/2021.
//

import Foundation
import Combine

final class AppConfig: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()

    @StorageCodable(key: "theme", defaultValue: .light)
    var theme: Theme

    private var didChangeCancellable: AnyCancellable?

    init() {
        didChangeCancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .subscribe(objectWillChange)
    }
}
