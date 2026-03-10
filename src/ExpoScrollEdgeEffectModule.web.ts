import { registerWebModule, NativeModule } from 'expo';

import { ExpoScrollEdgeEffectModuleEvents } from './ExpoScrollEdgeEffect.types';

class ExpoScrollEdgeEffectModule extends NativeModule<ExpoScrollEdgeEffectModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoScrollEdgeEffectModule, 'ExpoScrollEdgeEffectModule');
