require('dotenv').config(); // Load env vars at the top

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const app = express();

// Use a fixed port, or fallback to 3000
const port = process.env.PORT || 3000;

// PostgreSQL connection using environment variables
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT || 5432, // Default PostgreSQL port
});

app.use(cors());
app.use(bodyParser.json());

// Function to create tables if they do not exist
const createTables = async () => {
  const createUsersTableQuery = `
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      email VARCHAR(255) UNIQUE NOT NULL,
      password VARCHAR(255) NOT NULL
    );
  `;

  const createEventsTableQuery = `
    CREATE TABLE IF NOT EXISTS events (
      id SERIAL PRIMARY KEY,
      title VARCHAR(255) NOT NULL,
      date DATE NOT NULL,
      time TIME NOT NULL,
      location VARCHAR(255) NOT NULL,
      description TEXT,
      image_url TEXT
    );
  `;

  try {
    await pool.query(createUsersTableQuery);
    await pool.query(createEventsTableQuery);
    console.log("Tables created or already exist.");
  } catch (err) {
    console.error("Error creating tables:", err);
  }
};

createTables();

// Endpoint to get events
app.get('/events', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM events ORDER BY date ASC, time ASC');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

// Endpoint to get today's events
app.get('/events/today', async (req, res) => {
  try {
    const today = new Date().toISOString().split('T')[0]; // 'YYYY-MM-DD'
    const result = await pool.query(
      'SELECT * FROM events WHERE date = $1 ORDER BY time ASC',
      [today]
    );
    res.json(result.rows);
  } catch (err) {
    console.error('Error fetching events:', err);
    res.status(500).send('Server error');
  }
});

// Add new event
app.post('/events', async (req, res) => {
  const { title, date, time, location, description, image_url } = req.body;

  if (!title || !date || !time || !location) {
    return res.status(400).send('Missing required fields');
  }

  try {
    const result = await pool.query(
      'INSERT INTO events (title, date, time, location, description, image_url) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [title, date, time, location, description, image_url]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Error adding event:', err);
    res.status(500).send('Server error');
  }
});

// Register a new user
app.post('/register', async (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).send('Missing required fields');
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const result = await pool.query(
      'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id, name, email',
      [name, email, hashedPassword]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error during registration:", err);
    res.status(500).send('Server error');
  }
});

// Get user profile
app.get('/user/profile', async (req, res) => {
  const userId = parseInt(req.headers['user-id'], 10);
  if (!userId) return res.status(401).send('User ID not provided');
  
  try {
    const result = await pool.query('SELECT id, name, email FROM users WHERE id = $1', [userId]);
    if (result.rows.length === 0) {
      return res.status(404).send('User not found');
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error('Error fetching user profile:', err);
    res.status(500).send('Server error');
  }
});

// Update user profile
app.put('/user/profile', async (req, res) => {
  const userId = parseInt(req.headers['user-id'], 10);
  if (!userId) return res.status(401).send('User ID not provided');
  
  const { name, email } = req.body;
  if (!name || !email) {
    return res.status(400).send('Missing required fields');
  }

  try {
    const result = await pool.query(
      'UPDATE users SET name = $1, email = $2 WHERE id = $3 RETURNING id, name, email',
      [name, email, userId]
    );
    if (result.rows.length === 0) {
      return res.status(404).send('User not found');
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error('Error updating user profile:', err);
    res.status(500).send('Server error');
  }
});

// Login
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).send('Missing email or password');
  }

  try {
    const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(401).send('Invalid email');
    }

    const user = result.rows[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).send('Invalid password');
    }

    res.status(200).json({ message: 'Login successful', user: { id: user.id, name: user.name, email: user.email } });
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).send('Server error');
  }
});

// Start server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
