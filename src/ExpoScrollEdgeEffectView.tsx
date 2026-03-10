import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoScrollEdgeEffectViewProps } from './ExpoScrollEdgeEffect.types';

const NativeView: React.ComponentType<ExpoScrollEdgeEffectViewProps> =
  requireNativeView('ExpoScrollEdgeEffect');

export default function ExpoScrollEdgeEffectView(props: ExpoScrollEdgeEffectViewProps) {
  return <NativeView {...props} />;
}
