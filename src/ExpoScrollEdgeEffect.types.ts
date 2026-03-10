import type { PropsWithChildren } from "react";
import type { ViewProps } from "react-native";

export type Edge = "top" | "bottom" | "left" | "right";

export type EffectStyle = "automatic" | "hard" | "soft" | "hidden";

export type ScrollEdgeEffectProps = PropsWithChildren<
  {
    edge: Edge;
    effect?: EffectStyle;
    fallbackStyle?: ViewProps["style"];
  } & Omit<ViewProps, "children">
>;

export type NativeScrollEdgeEffectViewProps = PropsWithChildren<
  {
    scrollViewTag: number | null;
    edge: Edge;
    effect: EffectStyle;
  } & Omit<ViewProps, "children">
>;
