import React, { useRef, useEffect, useState } from 'react';

export function CameraView() { 
  const videoRef = useRef(null);
  const [error, setError] = useState(null);
  const [isReady, setIsReady] = useState(false);

  if (error) {
    return <p style={{ color: 'red', padding: '10px' }}>🚨 Erro na Câmera: {error}</p>;
  }

return (
  <div>
    <p>Câmera carregando...</p>
  </div>
);

}
  
