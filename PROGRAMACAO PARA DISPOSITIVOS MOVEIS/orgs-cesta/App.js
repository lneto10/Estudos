import React from 'react';
import { StatusBar,SafeAreaView, StyleSheet, View } from 'react-native';
import { useFonts, Montserrat_400Regular, Montserrat_700Bold, Montserrat_400 } from '@expo-google-fonts/montserrat';
import Cesta from './src/telas/Cesta';

export default function App() {
  const[fonteCarregada] = useFonts({
    "MontserratRegular": Montserrat_400Regular,
    "montserratBold": Montserrat_700Bold,
  });

  if (!fonteCarregada){
    return <View />
  }
  return (
    <SafeAreaView>
      <StatusBar />
      <Cesta />
    </SafeAreaView>
  );
}
