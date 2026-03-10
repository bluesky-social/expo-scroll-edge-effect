import type { PropsWithChildren } from 'react';
import type { StyleProp, ViewStyle } from 'react-native';

export type Edge = 'top' | 'bottom' | 'left' | 'right';

export type ScrollEdgeEffectProps = PropsWithChildren<{
  edge: Edge;
  style?: StyleProp<ViewStyle>;
}>;

export type NativeScrollEdgeEffectViewProps = PropsWithChildren<{
  scrollViewTag: number | null;
  edge: Edge;
  style?: StyleProp<ViewStyle>;
}>;
