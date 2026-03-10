// Reexport the native module. On web, it will be resolved to ExpoScrollEdgeEffectModule.web.ts
// and on native platforms to ExpoScrollEdgeEffectModule.ts
export { default } from './ExpoScrollEdgeEffectModule';
export { default as ExpoScrollEdgeEffectView } from './ExpoScrollEdgeEffectView';
export * from  './ExpoScrollEdgeEffect.types';
