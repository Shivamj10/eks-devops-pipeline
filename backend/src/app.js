const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

let bookings = [];

app.get('/', (req, res) => {
  res.send('🚀 Booking Backend is running');
});

app.get('/bookings', (req, res) => {
  res.json(bookings);
});

app.post('/bookings', (req, res) => {
  const { name, email } = req.body;
  if (!name || !email) return res.status(400).json({ message: 'Name and email required' });

  const booking = { id: Date.now(), name, email };
  bookings.push(booking);

  console.log('New booking:', booking); // 👈 ADD THIS LINE

  res.status(201).json(booking);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Backend listening on port ${PORT}`));
