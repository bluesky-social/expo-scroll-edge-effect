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

  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
  }

  override func willMove(toWindow newWindow: UIWindow?) {
    super.willMove(toWindow: newWindow)
    if newWindow == nil {
      removeInteraction()
    } else {
      updateInteraction()
    }
  }

  private func updateInteraction() {
    removeInteraction()

    guard window != nil else { return }
    guard let tag = scrollViewTag else { return }

    guard #available(iOS 26, *) else { return }

    guard let scrollView = resolveScrollView(tag: tag) else { return }

    let interaction = UIScrollEdgeElementContainerInteraction()
    interaction.scrollView = scrollView
    interaction.edge = resolveEdge(edge)
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

    // RCTScrollView / RCTScrollViewComponentView wrap UIScrollView as a subview
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
}
