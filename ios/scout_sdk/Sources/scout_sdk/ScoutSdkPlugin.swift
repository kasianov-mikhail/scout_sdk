#if canImport(Scout)
import Scout
#endif
import CloudKit
import Flutter
import SwiftUI
import UIKit

public class ScoutSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "scout_sdk",
            binaryMessenger: registrar.messenger()
        )
        let instance = ScoutSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setup":
            handleSetup(call, result: result)
        case "showDashboard":
            handleShowDashboard(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleSetup(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        #if canImport(Scout)
        guard let args = call.arguments as? [String: Any],
              let containerId = args["containerId"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing containerId", details: nil))
            return
        }
        let container = CKContainer(identifier: containerId)
        Task { @MainActor in
            do {
                try await setup(container: container)
                result(nil)
            } catch {
                result(FlutterError(code: "SETUP_ERROR", message: error.localizedDescription, details: nil))
            }
        }
        #else
        result(FlutterError(
            code: "UNAVAILABLE",
            message: "Scout requires Swift Package Manager.",
            details: nil
        ))
        #endif
    }

    private func handleShowDashboard(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        #if canImport(Scout)
        guard let args = call.arguments as? [String: Any],
              let containerId = args["containerId"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing containerId", details: nil))
            return
        }

        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                  let rootViewController = windowScene.windows
                .first(where: { $0.isKeyWindow })?.rootViewController else {
                result(FlutterError(
                    code: "NO_VIEW_CONTROLLER",
                    message: "Unable to find root view controller",
                    details: nil
                ))
                return
            }

            let container = CKContainer(identifier: containerId)
            let homeView = HomeView(container: container)
            let hostingController = UIHostingController(rootView: homeView)
            hostingController.modalPresentationStyle = .fullScreen

            var presenter = rootViewController
            while let presented = presenter.presentedViewController {
                presenter = presented
            }
            presenter.present(hostingController, animated: true)
            result(nil)
        }
        #else
        result(FlutterError(
            code: "UNAVAILABLE",
            message: "Scout requires Swift Package Manager.",
            details: nil
        ))
        #endif
    }
}
