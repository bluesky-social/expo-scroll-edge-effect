import ExpoModulesCore
import UIKit

class ExpoScrollEdgeEffectView: ExpoView {
  private var currentInteraction: NSObject?

  var scrollViewTag: Int? {
    didSet {
      if scrollViewTag != oldValue {
        updateInteraction()
      }
    }
  }

  var edge: String = "top" {
    didSet {
      if edge != oldValue {
        updateInteraction()
      }
    }
  }

  var effect: String = "automatic" {
    didSet {
      if effect != oldValue {
        updateInteraction()
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
      updateInteraction()
    }
  }

  private func updateInteraction() {
    removeInteraction()

    guard window != nil else { return }
    guard let tag = scrollViewTag else { return }
    guard #available(iOS 26, *) else { return }
    guard let scrollView = resolveScrollView(tag: tag) else { return }

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

    let interaction = UIScrollEdgeElementContainerInteraction()
    interaction.scrollView = scrollView
    interaction.edge = resolvedEdge
    addInteraction(interaction)
    currentInteraction = interaction
  }

  private func removeInteraction() {
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
