import React from 'react';
import { View } from 'react-native';

import type { ScrollEdgeEffectProps } from './ExpoScrollEdgeEffect.types';

export function ScrollEdgeEffect({
  children,
  style,
}: ScrollEdgeEffectProps) {
  return <View style={style}>{children}</View>;
}
