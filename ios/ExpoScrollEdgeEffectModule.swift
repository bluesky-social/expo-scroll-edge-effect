import ExpoModulesCore

public class ExpoScrollEdgeEffectModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoScrollEdgeEffect")

    View(ExpoScrollEdgeEffectView.self) {
      Prop("scrollViewTag") { (view: ExpoScrollEdgeEffectView, tag: Int?) in
        view.scrollViewTag = tag
      }

      Prop("edge") { (view: ExpoScrollEdgeEffectView, edge: String) in
        view.edge = edge
      }

      Prop("effect") { (view: ExpoScrollEdgeEffectView, effect: String) in
        view.effect = effect
      }
    }
  }
}
