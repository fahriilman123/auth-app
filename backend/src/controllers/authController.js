const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const crypto = require('crypto')

exports.register = (req, res) => {
    const { name, email, password} = req.body;


    if(!name || !email || !password) {
        return res.status(400).json({
            age: 'nama, email, dan password wajib di isi'
        })
    }

    const checkQuery = 'SELECT id FROM users WHERE email = ?'
    db.query(checkQuery, [email], async(err, result) => {
        if (err){
            return res.status(500).json({message: 'Database error'})
        }
        if (result.length > 0){
            return res.status(409).json({message: 'Email sudah terdaftar'})
        }

        const hashPassword = await bcrypt.hash(password, 10)

        const insertQuerry = 'INSERT INTO users (name, email, password) VALUES (?, ?, ?)';

        db.query(insertQuerry, [name, email, hashPassword], (err) => {
            if(err){
                return res.status(500).json({message: 'Gagal mendaftar'})
            }
            res.status(201).json({
                message: "Registrasi berhasil"
            })   
        })
    })
}

exports.login = (req, res) => {
    const {email, password} = req.body

    if(!email || !password) {
        return res.status(400).json({
            messsage: 'email dan password wajib di isi'
        })
    }

    const checkQuery = 'SELECT * FROM users WHERE email = ?'
    db.query(checkQuery, [email], async(err, result) => {
        if (err){
            return res.status(500).json({message: 'Database error'})
        }
        if (result.length === 0){
            return res.status(404).json({message: 'Email tidak terdaftar'})
        }

        const user = result[0]

        const isMatch = await bcrypt.compare(password, user.password)
        if(!isMatch){
            return res.status(401).json({message: 'Password salah'})
        }

        const token = jwt.sign(
            {id: user.id, name: user.name, email: user.email},
            process.env.JWT_SECRET,
            {expiresIn: '1h'}
        )

        res.status(200).json({
            message: 'Login berhasil',
            token : token,
            user: {
                id: user.id, 
                name: user.name, 
                email: user.email
            }
        })
    })
}

exports.forgotPassword = (req, res) => {
    const {email} = req.body

    if(!email) {
        return res.status(400).json({
            messsage: 'email wajib di isi'
        })
    }

    const checkQuery = 'SELECT id FROM users WHERE email = ?'
    db.query(checkQuery, [email], async(err, result) => { 
        if (err){
            return res.status(500).json({message: 'Database error'})
        }
        if (result.length === 0){
            return res.status(404).json({message: 'Email tidak terdaftar'})
        }

        const resetToken = crypto.randomBytes(20).toString('hex')
        const expired = new Date(Date.now() + 5 * 60 * 1000)

        const updateQuery = 'UPDATE users set reset_token = ?, reset_token_expired = ? WHERE email = ?'
        db.query(updateQuery, [resetToken, expired, email], (err) => { 
            if (err) {
                return res.status(500).json({ message: 'Gagal generate token' });
            }

            res.status(200).json({
                message: 'Token reset password berhasil dibuat',
                reset_token: resetToken
            });
        })
    })
}

exports.resetPassword = async(req, res) => {
    const {token, newPassword} = req.body

    if(!token || !newPassword) {
        return res.status(400).json({
            messsage: 'Token dan password baru wajib di isi'
        })
    }

    const query = 'SELECT * FROM users where reset_token = ? AND reset_token_expired > NOW()'

    db.query(query, [token], async (err, result) => { 
        if (err){
            return res.status(500).json({message: 'Database error'})
        }

        if (result.length === 0){
            return res.status(400).json({message: 'Token tidak valid atau sudah kadaluarsa'})
        }

        const hashPassword = await bcrypt.hash(newPassword, 10)

        const updateQuery = "UPDATE users set password = ?, reset_token = NULL, reset_token_expired = NULL WHERE id = ?"
        db.query(updateQuery, [hashPassword, result[0].id], (err) => { 
            if (err) {
                return res.status(500).json({ message: 'Gagal reset password' });
            }
            res.status(200).json({
                message: 'password berhasil di ubah'
            });
        })
    })
}