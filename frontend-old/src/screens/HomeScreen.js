import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import Carousel from '../components/Carousel';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.header}>Welcome to EOEX App Store</Text>
      <Carousel />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff', padding: 16 },
  header: { fontSize: 24, fontWeight: 'bold', marginBottom: 16 },
});
