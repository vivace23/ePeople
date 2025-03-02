const express = require("express");
const pool = require("./db");
require("dotenv").config();

const app = express();
const PORT = process.env.SERVER_PORT;

const authCovoitureur = require('./module_authentification/authentification_covoitureur');



// pour utiliser les données en format json new
app.use(express.json());
app.set('timeout', 60000); // 60 secondes

// pour utiliser la route addCovoitureur.js
app.use('/authCovoitureur', authCovoitureur);


// Route pour tester la connexion à MySQL
app.get("/ffff", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT NOW() AS timestamp");
    res.json({ message: "Connexion réussie !", timestamp: rows[0].timestamp });
  } catch (error) {
    console.error("Erreur de connexion à MySQL domage:", error.message);
    res.status(500).json({ error: error.message });
  }
});

// Lancer le serveur
app.listen(PORT, () => console.log(`Serveur en écoute sur http://localhost:${PORT}`));
