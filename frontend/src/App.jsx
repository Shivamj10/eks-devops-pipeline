import { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [bookings, setBookings] = useState([]);
  const [formData, setFormData] = useState({ name: '', email: '' });

  useEffect(() => {
    fetch('http://localhost:3000/bookings')
      .then(res => res.json())
      .then(data => setBookings(data));
  }, []);

  const handleChange = e => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async e => {
    e.preventDefault();
    const res = await fetch('http://localhost:3000/bookings'
, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(formData),
    });
    const newBooking = await res.json();
    setBookings(prev => [...prev, newBooking]);
    setFormData({ name: '', email: '' });
  };

  return (
    <div className="container">
      <h1>📘 Booking App</h1>

      <form onSubmit={handleSubmit}>
        <input
          name="name"
          placeholder="Name"
          value={formData.name}
          onChange={handleChange}
          required
        />
        <input
          name="email"
          placeholder="Email"
          type="email"
          value={formData.email}
          onChange={handleChange}
          required
        />
        <button type="submit">Book</button>
      </form>

      <h2>📋 Current Bookings</h2>
      <ul>
        {bookings.map(b => (
          <li key={b.id}>
            {b.name} ({b.email})
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
