import React from 'react';
import './App.css';

import GeoLocator from './components/GeoLocator'; // Corrigido: importação default
import { CameraView } from './components/CameraView';

function App() {
  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '0 auto' }}>
      
      <h1>App PWA com Sensores</h1>
      <p>Testando Câmera e Geolocalização em um ambiente Vite + React.</p>

      <GeoLocator />
      <CameraView />

      <p style={{ marginTop: '40px', fontSize: 'small', color: '#666' }}>
        <strong>Lembrete de PWA:</strong> O acesso à câmera e geolocalização exige conexão HTTPS para funcionar em produção (ou localhost para desenvolvimento).
      </p>

    </div>
  );
}

export default App;
