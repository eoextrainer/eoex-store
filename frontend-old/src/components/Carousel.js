import React, { useEffect, useState } from 'react';
import { View, Text, ScrollView, StyleSheet } from 'react-native';
import axios from 'axios';

export default function Carousel() {
  const [apps, setApps] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:8000/apps')
      .then(res => setApps(res.data))
      .catch(() => setApps([]));
  }, []);

  return (
    <ScrollView horizontal style={styles.carousel} showsHorizontalScrollIndicator={false}>
      {apps.map(app => (
        <View key={app.id} style={styles.card}>
          <Text style={styles.name}>{app.name}</Text>
          <Text style={styles.desc}>{app.description}</Text>
        </View>
      ))}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  carousel: { flexDirection: 'row', marginVertical: 16 },
  card: { width: 200, height: 120, backgroundColor: '#eee', borderRadius: 8, marginRight: 12, padding: 16, justifyContent: 'center' },
  name: { fontWeight: 'bold', fontSize: 18 },
  desc: { color: '#555' },
});
