require("dotenv").config();
const mysql = require("mysql2");

// Créer une connexion MySQL avec un pool de connexions
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// Vérifier la connexion
pool.getConnection((err, connection) => {
  if (err) {
    console.error("Erreur de connexion à  MySQL:", err.message);
  } else {
    console.log("Connexion réussie à MySQL !");
    connection.release();
  }
});

module.exports = pool.promise(); // Utilisation avec async/await
