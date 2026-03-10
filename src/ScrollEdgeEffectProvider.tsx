import React, { createContext, useCallback, useContext, useState } from 'react';
import { findNodeHandle } from 'react-native';

type ScrollEdgeEffectContextValue = {
  scrollViewTag: number | null;
};

const ScrollEdgeEffectContext = createContext<ScrollEdgeEffectContextValue>({
  scrollViewTag: null,
});

export function ScrollEdgeEffectProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [scrollViewTag, setScrollViewTag] = useState<number | null>(null);

  const ref = useCallback((node: any) => {
    if (node == null) {
      setScrollViewTag(null);
    } else {
      const tag = findNodeHandle(node);
      setScrollViewTag(tag);
    }
  }, []);

  return (
    <ScrollEdgeEffectContext.Provider value={{ scrollViewTag }}>
      <ScrollEdgeEffectRefContext.Provider value={ref}>
        {children}
      </ScrollEdgeEffectRefContext.Provider>
    </ScrollEdgeEffectContext.Provider>
  );
}

const ScrollEdgeEffectRefContext = createContext<
  ((node: any) => void) | null
>(null);

export function useScrollEdgeEffectRef() {
  const ref = useContext(ScrollEdgeEffectRefContext);
  if (ref == null) {
    throw new Error(
      'useScrollEdgeEffectRef must be used within a ScrollEdgeEffectProvider'
    );
  }
  return ref;
}

export function useScrollEdgeEffectContext() {
  return useContext(ScrollEdgeEffectContext);
}
