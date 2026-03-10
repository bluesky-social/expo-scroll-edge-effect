import React from "react";
import { Platform } from "react-native";

import type { ScrollEdgeEffectProps } from "./ExpoScrollEdgeEffect.types";
import { NativeView } from "./ExpoScrollEdgeEffectView";
import { useScrollEdgeEffectContext } from "./ScrollEdgeEffectProvider";

const supportsEdgeEffect =
  parseInt(String(Platform.Version), 10) >= 26;

export function ScrollEdgeEffect({
  edge,
  effect = "automatic",
  children,
  fallbackStyle,
  style,
  ...props
}: ScrollEdgeEffectProps) {
  const { scrollViewTag } = useScrollEdgeEffectContext();

  return (
    <NativeView
      scrollViewTag={scrollViewTag}
      edge={edge}
      effect={effect}
      style={!supportsEdgeEffect ? [style, fallbackStyle] : style}
      {...props}
    >
      {children}
    </NativeView>
  );
}
