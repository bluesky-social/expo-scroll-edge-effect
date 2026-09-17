import ExpoModulesCore
import UIKit

class ExpoScrollEdgeEffectView: ExpoView {
  private var currentInteraction: NSObject?

  private var pocketElementView: UIImageView?

  private static let clearImage: UIImage = {
    UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in }
  }()

  private var isAttached = false
  private var resolveAttempts = 0
  private let maxResolveAttempts = 30

  var scrollViewTag: Int? {
    didSet {
      if scrollViewTag != oldValue {
        scheduleResolve()
      }
    }
  }

  var edge: String = "top" {
    didSet {
      if edge != oldValue {
        scheduleResolve()
      }
    }
  }

  var effect: String = "automatic" {
    didSet {
      if effect != oldValue {
        scheduleResolve()
      }
    }
  }

  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
  }

  override func willMove(toWindow newWindow: UIWindow?) {
    super.willMove(toWindow: newWindow)
    if newWindow == nil {
      removeInteraction()
    }
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()
    if window != nil {
      scheduleResolve()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    // React Native mounts children by absolute subview index, so the element
    // view must stay last to keep those indices valid.
    if let pocketElementView, subviews.last !== pocketElementView {
      bringSubviewToFront(pocketElementView)
    }

    if !isAttached, window != nil, scrollViewTag != nil, resolveAttempts < maxResolveAttempts {
      updateInteraction()
    }
  }

  private func ensurePocketElementView() {
    if pocketElementView != nil {
      return
    }
    let view = UIImageView(frame: bounds)
    view.image = Self.clearImage
    view.isUserInteractionEnabled = false
    view.isAccessibilityElement = false
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
    pocketElementView = view
  }

  private func scheduleResolve() {
    resolveAttempts = 0
    updateInteraction()
  }

  private func updateInteraction() {
    removeInteraction()

    guard window != nil else { return }
    guard let tag = scrollViewTag else { return }
    guard #available(iOS 26, *) else { return }
    guard let scrollView = resolveScrollView(tag: tag) else {
      if resolveAttempts < maxResolveAttempts {
        resolveAttempts += 1
        setNeedsLayout()
      }
      return
    }

    resolveAttempts = 0
    isAttached = true

    let resolvedEdge = self.resolveEdge(edge)
    let resolvedStyle = self.resolveEffectStyle(effect)

    if let resolvedStyle = resolvedStyle {
      switch resolvedEdge {
      case .top: scrollView.topEdgeEffect.style = resolvedStyle
      case .bottom: scrollView.bottomEdgeEffect.style = resolvedStyle
      case .left: scrollView.leftEdgeEffect.style = resolvedStyle
      case .right: scrollView.rightEdgeEffect.style = resolvedStyle
      default: break
      }
    }

    if self.effect == "hidden" {
      return
    }

    ensurePocketElementView()

    let interaction = UIScrollEdgeElementContainerInteraction()
    interaction.scrollView = scrollView
    interaction.edge = resolvedEdge
    addInteraction(interaction)
    currentInteraction = interaction
  }

  private func removeInteraction() {
    isAttached = false

    guard #available(iOS 26, *) else { return }

    if let interaction = currentInteraction as? UIScrollEdgeElementContainerInteraction {
      removeInteraction(interaction)
    }
    currentInteraction = nil
  }

  private func resolveScrollView(tag: Int) -> UIScrollView? {
    guard let view = appContext?.findView(withTag: tag, ofType: UIView.self) else {
      return nil
    }

    if let scrollView = view as? UIScrollView {
      return scrollView
    }

    for subview in view.subviews {
      if let scrollView = subview as? UIScrollView {
        return scrollView
      }
    }

    return nil
  }

  @available(iOS 26, *)
  private func resolveEdge(_ edge: String) -> UIRectEdge {
    switch edge {
    case "top": return .top
    case "bottom": return .bottom
    case "left": return .left
    case "right": return .right
    default: return .top
    }
  }

  @available(iOS 26, *)
  private func resolveEffectStyle(_ effect: String) -> UIScrollEdgeEffect.Style? {
    switch effect {
    case "automatic": return .automatic
    case "hard": return .hard
    case "soft": return .soft
    case "hidden": return nil
    default: return .automatic
    }
  }
}
