import React from "react";
import { View } from "react-native";

import type { ScrollEdgeEffectProps } from "./ExpoScrollEdgeEffect.types";

export function ScrollEdgeEffect({
  edge: _edge,
  effect: _effect,
  children,
  style,
  fallbackStyle,
  ...props
}: ScrollEdgeEffectProps) {
  return (
    <View style={[style, fallbackStyle]} {...props}>
      {children}
    </View>
  );
}
