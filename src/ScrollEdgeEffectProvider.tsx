import { NodeHandle } from "react-native";

export function ScrollEdgeEffectProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}

export function useScrollEdgeEffectRef(): ((node: any) => void) | undefined {
  return undefined;
}

export function useScrollEdgeEffectContext(): {
  scrollViewTag: null | NodeHandle;
} {
  return { scrollViewTag: null };
}
