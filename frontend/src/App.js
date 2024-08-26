import React, { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [weatherData, setWeatherData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch('http://localhost:3000/weatherforecast') 
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        setWeatherData(data);
        setLoading(false);
      })
      .catch(error => {
        setError(error.message);
        setLoading(false);
      });
  }, []);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div className="App">
      <h1>Weather Forecast</h1>
      <ul>
        {weatherData.map((forecast, index) => (
          <li key={index}>
            <strong>{new Date(forecast.date).toLocaleDateString()}</strong>: {forecast.summary}, {forecast.temperatureC}°C
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;

