export function ScrollEdgeEffectProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}

export function useScrollEdgeEffectRef() {
  return undefined;
}

export function useScrollEdgeEffectContext() {
  return { scrollViewTag: null };
}
