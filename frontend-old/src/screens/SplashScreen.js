import React, { useEffect } from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function SplashScreen({ navigation }) {
  useEffect(() => {
    setTimeout(() => {
      navigation.replace('Home');
    }, 1500);
  }, [navigation]);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>EOEX App Store</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: '#222' },
  title: { color: '#fff', fontSize: 32, fontWeight: 'bold' },
});
