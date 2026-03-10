import { requireNativeView } from 'expo';

import { NativeScrollEdgeEffectViewProps } from './ExpoScrollEdgeEffect.types';

export const NativeView: React.ComponentType<NativeScrollEdgeEffectViewProps> =
  requireNativeView('ExpoScrollEdgeEffect');
