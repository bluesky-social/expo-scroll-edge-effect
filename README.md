# @bsky.app/expo-scroll-edge-effect

An Expo module wrapping [`UIScrollEdgeElementContainerInteraction`](https://developer.apple.com/documentation/uikit/uiscrolledgeelementcontainerinteraction) (iOS 26+). Allows views overlaying the edges of a scroll view to automatically influence the scroll edge effect shape.

On older iOS versions and other platforms, the components render as plain `View`s.

## Installation

```sh
npm install @bsky.app/expo-scroll-edge-effect
```

Then run `npx pod-install` to link the native module.

> Requires [`expo`](https://docs.expo.dev/bare/installing-expo-modules/) to be configured in your project.

## Usage

```tsx
import {
  ScrollEdgeEffectProvider,
  ScrollEdgeEffect,
  useScrollEdgeEffectRef,
} from "@bsky.app/expo-scroll-edge-effect";

function Screen() {
  return (
    <ScrollEdgeEffectProvider>
      <ScrollEdgeEffect edge="top">
        <MyHeader />
      </ScrollEdgeEffect>

      <ScrollContent />

      <ScrollEdgeEffect edge="bottom">
        <MyFooter />
      </ScrollEdgeEffect>
    </ScrollEdgeEffectProvider>
  );
}

function ScrollContent() {
  const scrollEdgeRef = useScrollEdgeEffectRef();

  return (
    <ScrollView ref={scrollEdgeRef}>
      {/* ... */}
    </ScrollView>
  );
}
```

### With Reanimated

The ref returned by `useScrollEdgeEffectRef` is a callback ref, so it works with `mergeRefs`:

```tsx
const animatedRef = useAnimatedRef();
const scrollEdgeRef = useScrollEdgeEffectRef();

<Animated.ScrollView ref={mergeRefs([animatedRef, scrollEdgeRef])} />
```

## API

### `<ScrollEdgeEffectProvider>`

Wraps your screen content. Holds the scroll view reference in context so that `<ScrollEdgeEffect>` components can attach to it.

### `useScrollEdgeEffectRef()`

Returns a callback ref to pass to your `ScrollView`. Must be used within a `<ScrollEdgeEffectProvider>`.

### `<ScrollEdgeEffect>`

Wraps content that overlays a scroll view edge. On iOS 26+, descendant views (labels, buttons, images, etc.) automatically influence the scroll edge effect shape.

| Prop | Type | Description |
|------|------|-------------|
| `edge` | `'top' \| 'bottom' \| 'left' \| 'right'` | Which scroll view edge this content overlays. |
| `fallbackStyle` | `ViewStyle` | Additional style applied only on non-iOS platforms. |
| `...viewProps` | `ViewProps` | All standard View props are forwarded. |

## Platform support

| Platform | Behavior |
|----------|----------|
| iOS 26+  | Native `UIScrollEdgeElementContainerInteraction` |
| iOS < 26 | Renders as a plain `View` (no crash) |
| Android / Web | Renders as a plain `View` |

## License

MIT
