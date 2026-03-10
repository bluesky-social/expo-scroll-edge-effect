import { NativeModule, requireNativeModule } from 'expo';

import { ExpoScrollEdgeEffectModuleEvents } from './ExpoScrollEdgeEffect.types';

declare class ExpoScrollEdgeEffectModule extends NativeModule<ExpoScrollEdgeEffectModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoScrollEdgeEffectModule>('ExpoScrollEdgeEffect');
