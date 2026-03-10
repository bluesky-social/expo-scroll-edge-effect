import React from 'react';

import type { ScrollEdgeEffectProps } from './ExpoScrollEdgeEffect.types';
import { NativeView } from './ExpoScrollEdgeEffectView';
import { useScrollEdgeEffectContext } from './ScrollEdgeEffectProvider';

export function ScrollEdgeEffect({
  edge,
  children,
  style,
}: ScrollEdgeEffectProps) {
  const { scrollViewTag } = useScrollEdgeEffectContext();

  return (
    <NativeView scrollViewTag={scrollViewTag} edge={edge} style={style}>
      {children}
    </NativeView>
  );
}
