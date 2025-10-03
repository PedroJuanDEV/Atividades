import React from 'react';
import { useGeolocation } from '../hooks/useGeolocation';

export default function GeoLocator() {  

  const { location, error, isLoading } = useGeolocation();
  if (isLoading) {
    return <p>📡 Buscando sua localização...</p>;
  }

  if (error) {
    return <p style={{ color: 'red', padding: '10px', border: '1px solid red' }}>🚨 Erro de Geolocalização: {error}</p>;
  }

  if (location) {
    return (
      <div style={{ padding: '10px', border: '1px solid green' }}>
        <h2>📍 Sua Localização Atual</h2>
        <p>Latitude: <strong>{location.latitude.toFixed(6)}</strong></p>
        <p>Longitude: <strong>{location.longitude.toFixed(6)}</strong></p>
      </div>
    );
  }

  // Fallback caso não esteja carregando e não tenha localização/erro (raro, mas bom ter)
  return <p>Geolocalização indisponível.</p>;
}