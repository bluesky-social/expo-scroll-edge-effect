import { GlassView } from "expo-glass-effect";
import {
  ScrollEdgeEffect,
  ScrollEdgeEffectProvider,
  useScrollEdgeEffectRef,
} from "expo-scroll-edge-effect";
import { Image, ScrollView, StyleSheet, Text, View } from "react-native";
import {
  initialWindowMetrics,
  SafeAreaProvider,
  useSafeAreaInsets,
} from "react-native-safe-area-context";

const logo = require("./assets/logo.png");

export default function App() {
  return (
    <SafeAreaProvider initialMetrics={initialWindowMetrics}>
      <ScrollEdgeEffectProvider>
        <ScrollContent />
        <Header />
        <Footer />
      </ScrollEdgeEffectProvider>
    </SafeAreaProvider>
  );
}

function Header() {
  const insets = useSafeAreaInsets();
  return (
    <ScrollEdgeEffect
      edge="top"
      style={[styles.header, { paddingTop: insets.top }]}
      fallbackStyle={styles.fallback}
    >
      <Image source={logo} style={styles.headerImage} resizeMode="contain" />
      <Text style={styles.headerText}>Example app</Text>
    </ScrollEdgeEffect>
  );
}

function ScrollContent() {
  const scrollEdgeRef = useScrollEdgeEffectRef();

  return (
    <ScrollView
      ref={scrollEdgeRef}
      style={styles.scrollView}
      contentContainerStyle={{ paddingVertical: 48 }}
      contentInsetAdjustmentBehavior="automatic"
    >
      {Array.from({ length: 50 }, (_, i) => (
        <View key={i} style={styles.item}>
          <Text style={styles.itemText}>Item {i + 1}</Text>
        </View>
      ))}
    </ScrollView>
  );
}

function Footer() {
  const insets = useSafeAreaInsets();
  return (
    <ScrollEdgeEffect
      edge="bottom"
      style={[styles.footer, { paddingBottom: insets.bottom }]}
      fallbackStyle={styles.fallback}
    >
      <GlassView
        style={styles.footerInner}
        isInteractive
        glassEffectStyle="clear"
      >
        <Text style={styles.footerText}>Look, it works for footers too!</Text>
      </GlassView>
    </ScrollEdgeEffect>
  );
}

const styles = StyleSheet.create({
  header: {
    paddingVertical: 16,
    paddingHorizontal: 24,
    flexDirection: "row",
    alignItems: "center",
    gap: 12,
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
  },
  headerImage: {
    width: 32,
    height: 32,
  },
  headerText: {
    fontSize: 32,
    fontWeight: "bold",
  },
  footer: {
    padding: 16,
    position: "absolute",
    bottom: 0,
    left: 0,
    right: 0,
    alignItems: "center",
  },
  footerText: {
    fontSize: 16,
    textAlign: "center",
    color: "#333",
  },
  scrollView: {
    flex: 1,
  },
  item: {
    padding: 20,
    marginHorizontal: 16,
    marginVertical: 4,
    backgroundColor: "#f0f0f0",
    borderRadius: 8,
  },
  itemText: {
    fontSize: 16,
  },
  footerInner: {
    borderRadius: 999,
    paddingVertical: 16,
    paddingHorizontal: 32,
  },
  fallback: {
    backgroundColor: "rgba(255, 255, 255, 0.9)",
  },
});
