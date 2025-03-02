const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken'); // Ajoute cette ligne si manquante
const bcrypt = require('bcrypt');
const db = require('../db');

// Clé secrète pour signer les JWT (à sécuriser en prod)
const SECRET_KEY=process.env.SECRET_KEY;

// Middleware pour vérifier le token
const authenticateToken = async (req, res, next) => {
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(403).json({ message: 'acces refusé, Token requis' });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    req.user = decoded;
    next();
  } catch (err) {
    res.status(403).json({ message: 'Token invalide ou expiré' });
  }
};


//pour verifier la connexion avec la session
router.get('/checkAuth', (req, res)=>{
  if (req.session.admin) {
    res.send({ loggedIn: true, admin: req.session.admin });
  } else {
    res.send({ loggedIn: false });
  }

});

//pour deconnection de l'admin
router.get('/deconnexion', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).send('Erreur lors de la destruction de la session.');
    }
    res.clearCookie('connect.sid'); // Supprime le cookie côté client
    res.send({ loggedIn: false });
  });
});

// pour envoyer un hello world

router.post('/hello', (req, res) => {
  res.status(200).json({ loggedIn: false, message: 'données reçu avec success' });
});

router.post('/sendData', (req, res) => {
  res.status(200).json({ loggedIn: false, message: 'données reçu avec success' });
});


// pour renitialiser le mot de passe de l'administrateur
router.post('/forgotPassword', (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).send({ statut: false, error: "Email requis" });
  }

  const sql = "SELECT * FROM developpeur WHERE email = ?";
  db.query(sql, [email], (err, results) => {
    if (err) {
      console.error('Erreur lors de la recherche du développeur:', err);
      return res.status(500).send({ statut: false, error: err });
    }

    if (results.length === 0) {
      return res.status(404).send({ statut: false, error: "Développeur non trouvé" });
    }

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'your-email@gmail.com',
        pass: 'your-email-password'
      }
    });

    const mailOptions = {
      from: 'your-email@gmail.com',
      to: email,
      subject: 'Réinitialisation du mot de passe',
      text: 'Cliquez sur ce lien pour réinitialiser votre mot de passe: <lien>'
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error('Erreur lors de l\'envoi de l\'email:', error);
        return res.status(500).send({ statut: false, error: error.message });
      }
      res.send({ statut: true, message: 'Email envoyé avec succès' });
    });
  });
});

//pour authentifier le covoitureur
router.post('/login', async (req, res) => {
  const { email, mot_de_passe } = req.body;

  if (!email || !mot_de_passe) {
    return res.status(400).json({ statut: false, message: 'Tous les champs email et mot_de_passe sont requis' });
  }

  try {
    const [rows] = await db.query('SELECT * FROM compte_connexion_covoitureur WHERE email = ?', [email]);
    if (rows.length === 0) {
      return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
    }

    const covoitureur = rows[0];

    //pour comparer le mot de passe crypté avec le mot de passe de l'utilisateur
    const match = await bcrypt.compare(mot_de_passe, user.password_c);

    if (!match) {
      return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
    }

    const token = jwt.sign({ covoitureurId: covoitureur.covoitureurId, email: covoitureur.email }, SECRET_KEY, { expiresIn: '2h' });

    res.status(200).json({ token: token, covoitureurId: covoitureur.covoitureurId, message: 'Connexion réussie' });

  } catch (err) {
    res.status(500).json({ message: 'Erreur serveur' });
  }
});




//creation et enregistrement de l'utilisateur
router.post('/register_utilisateur', async (req, res) => {

    const { nom, prenom, email, contact, sexe, date_naissance, username, mot_de_passe } = req.body;

    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    // Minimum 8 caractères, 1 majuscule, 1 minuscule, 1 chiffre, 1 caractère spécial

    const phoneRegex = /^\+?[1-9]\d{1,14}$/;
    // Format international simple (ex: +33123456789 ou 0123456789)

    const nameRegex = /^[a-zA-ZÀ-ÿ\s-]{2,50}$/;
    // Lettres, accents, espaces et tirets, 2-50 caractères

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    // Format email standard (ex: nom@domaine.com)

    let connection;

    if (!nom || !prenom || !email || !contact || !sexe || !mot_de_passe || !username) {
        return res.status(400).json({ statut: false, message: 'Tous les champs sont requis: nom, prenom, email, contact, sexe, date_naissance, mot_de_passe, username' });
    }

    //pour crypter le mot de passe de l'utilisateur
    const hashedPassword = await bcrypt.hash(mot_de_passe, 10);
  
    try {
      // Obtenir une connexion pour la transaction
        connection = await db.getConnection();
        await connection.beginTransaction(); // Démarrer la transaction
        
        // Requête SQL pour insérer un covoitureur
        const requeteAjoutCovoitureur = "INSERT INTO covoitureur (nom, prenom, email, contact, sexe, date_naissance) VALUES (?, ?, ?, ?, ?, ?)";
        const valuesAjoutCovoitureur = [nom, prenom, email, contact, sexe, date_naissance];


      // 1. Insérer dans la table utilisateur
      const [resultAjoutCovoitureur] = await connection.query(
        requeteAjoutCovoitureur,
        valuesAjoutCovoitureur
      );
      const covoitureurId = resultAjoutCovoitureur.insertId; // Récupérer l'ID généré
  
      // 2. Insérer dans la table compte_connexion_utilisateur
      await connection.query(
        'INSERT INTO compte_connexion_utilisateur (username, password_c, id_covoitureur, email) VALUES (?, ?, ?, ?)',
        [username, hashedPassword, covoitureurId, email] // Mot de passe en clair ici (à hasher en prod)
      );
  
      
  
      // Générer un JWT pour l'utilisateur inscrit
      const token = jwt.sign({ covoitureurId, email }, SECRET_KEY, { expiresIn: '1h' });

      // Si tout va bien, valider la transaction
      await connection.commit();

      res.status(200).json({ token: token, message: 'Inscription réussie', covoitureurId: covoitureurId });

    } catch (err) {
      // En cas d'erreur, annuler la transaction
      if (connection) await connection.rollback();

      if (err.sqlMessage.includes('email')) {
        return res.status(409).json({ field: 'email', message: 'Cet email est déjà utilisé', error: err.sqlMessage });
      }

      if (err.sqlMessage.includes('contact')) {
        return res.status(409).json({ field: 'contact', message: 'Ce numéro de téléphone est déjà utilisé', error: err.sqlMessage });
      }

      if (err.sqlMessage.includes('username')) {
        return res.status(409).json({ field: 'username', message: 'username est déjà utilisé', error: err.sqlMessage });
      }
      
    } finally {
      // Libérer la connexion
      if (connection) connection.release();
    }
});

//pour les informations de l'utilisateur
router.get('/profile', authenticateToken, async (req, res) => {
  const { id_covoitureur } = req.params; // Récupère le paramètre "id" de l'URL
  try {
    const [rows] = await db.query('SELECT * FROM compte_connexion_covoitureur WHERE id_covoitureur = ?', [id_covoitureur]);
    res.status(200).json({information: rows[0]});
  } catch (err) {
    console.log(err)
    res.status(500).json({ message: 'Erreur serveur', error: err.message });
  }
});

module.exports = router;