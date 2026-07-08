import { requireNativeView } from "expo";

import { type NativeScrollEdgeEffectViewProps } from "./ExpoScrollEdgeEffect.types";

export const NativeView: React.ComponentType<NativeScrollEdgeEffectViewProps> =
  requireNativeView("ExpoScrollEdgeEffect");
