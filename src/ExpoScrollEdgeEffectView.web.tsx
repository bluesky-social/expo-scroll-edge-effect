import * as React from 'react';

import { ExpoScrollEdgeEffectViewProps } from './ExpoScrollEdgeEffect.types';

export default function ExpoScrollEdgeEffectView(props: ExpoScrollEdgeEffectViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
