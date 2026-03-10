import {
  ScrollEdgeEffect,
  ScrollEdgeEffectProvider,
  useScrollEdgeEffectRef,
} from 'expo-scroll-edge-effect';
import { SafeAreaView, ScrollView, StyleSheet, Text, View } from 'react-native';

export default function App() {
  return (
    <ScrollEdgeEffectProvider>
      <SafeAreaView style={styles.container}>
        <ScrollEdgeEffect edge="top">
          <View style={styles.header}>
            <Text style={styles.headerText}>Header</Text>
          </View>
        </ScrollEdgeEffect>

        <ScrollContent />

        <ScrollEdgeEffect edge="bottom">
          <View style={styles.footer}>
            <Text style={styles.footerText}>Footer</Text>
          </View>
        </ScrollEdgeEffect>
      </SafeAreaView>
    </ScrollEdgeEffectProvider>
  );
}

function ScrollContent() {
  const scrollEdgeRef = useScrollEdgeEffectRef();

  return (
    <ScrollView ref={scrollEdgeRef} style={styles.scrollView}>
      {Array.from({ length: 50 }, (_, i) => (
        <View key={i} style={styles.item}>
          <Text style={styles.itemText}>Item {i + 1}</Text>
        </View>
      ))}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f0f0f0',
  },
  header: {
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#ccc',
  },
  headerText: {
    fontSize: 24,
    fontWeight: 'bold',
  },
  footer: {
    padding: 16,
    backgroundColor: '#fff',
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: '#ccc',
  },
  footerText: {
    fontSize: 16,
    textAlign: 'center',
    color: '#666',
  },
  scrollView: {
    flex: 1,
  },
  item: {
    padding: 20,
    marginHorizontal: 16,
    marginVertical: 4,
    backgroundColor: '#fff',
    borderRadius: 8,
  },
  itemText: {
    fontSize: 16,
  },
});
