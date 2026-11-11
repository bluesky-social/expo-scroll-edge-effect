import ExpoModulesCore
import UIKit

class ExpoScrollEdgeEffectView: ExpoView {
  private var currentInteraction: NSObject?

  private var pocketElementView: UIView?

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
    let view: UIView
    if #available(iOS 27, *), edge == "top" {
      // iOS 27 ignores a clear image view on the top edge, so the effect never
      // grows past the status bar. A plain view registers by its frame. The
      // other edges keep the clear image view: a plain view there removes the
      // effect that iOS 27 already draws over the scroll view's content inset.
      view = UIView(frame: bounds)
    } else {
      // iOS 26 ignores a plain empty view. A clear image view registers.
      let imageView = UIImageView(frame: bounds)
      imageView.image = Self.clearImage
      view = imageView
    }
    view.isUserInteractionEnabled = false
    view.isAccessibilityElement = false
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    if #available(iOS 27, *), edge == "bottom" {
      // iOS 27 starts the bottom effect at the lower side of the element, where
      // iOS 26 starts it at the upper side. A thin element on the upper side of
      // this view gives both versions the same start.
      view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
      view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
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
