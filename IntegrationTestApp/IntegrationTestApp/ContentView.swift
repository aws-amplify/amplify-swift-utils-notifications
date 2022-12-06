//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//
		

import SwiftUI
import AmplifyUtilsNotifications

struct ContentView: View {

    @State var showPermissionStatus: Bool = false
    @State var isPermissionGranted: Bool = false

    var body: some View {
        VStack {
            Button("Default permissions") {
                requestDefaultPermission()
            }

            Button("Alert and sound permissions") {
                requestPermission([.alert, .sound])
            }

            Button("Is permissions granted?") {
                checkPermissions()
            }
        }
        .alert(isPresented: $showPermissionStatus) {
            Alert(title: Text("Permissions granted: \(String(describing: isPermissionGranted))"))
        }
        .padding()
    }

    func requestDefaultPermission() {
        Task { @MainActor in
            do {
                try await AUNotificationPermissions.request()
            } catch {
                print("Failed to request default permission with error \(error)")
            }

        }
    }

    func requestPermission(_ options: UNAuthorizationOptions) {
        Task { @MainActor in
            do {
                try await AUNotificationPermissions.request(options)
            } catch {
                print("Failed to request permissions (\(options)) with error: \(error)")
            }
        }
    }

    func checkPermissions() {
        Task { @MainActor in
            isPermissionGranted = await AUNotificationPermissions.allowed
            showPermissionStatus = true
        }
    }
}
