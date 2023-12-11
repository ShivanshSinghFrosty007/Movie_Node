const espress = require('express');
const router = espress.Router();

const { MongoClient, ObjectId } = require('mongodb');
const client = new MongoClient("mongodb+srv://FrostyNodeApp:qwerty123@cluster0.cjsivdu.mongodb.net/?retryWrites=true&w=majority");

const authenticate = require('../auth/authKey');
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'deamonking05042002@gmail.com',
        pass: 'edqvtzcwnlwupcxd'
    }
});

router.post("/:key/getuser", async function (req, res) {
    if (!authenticate(req.params.key, res)) {
        return;
    }
    const find = await client.db("moviedb").collection("users").findOne({ username: req.body.username });
    if (find) {
        if (req.body.password == find['password']) {
            res.json({ acknowledged: true });
        } else {
            res.json({ acknowledged: 'wrong' });
        }
    } else {
        res.json({ acknowledged: false });
    }
    console.log('get user');
});

router.post("/:key/adduser", async function (req, res) {
    if (!authenticate(req.params.key, res)) {
        return;
    }
    const find = await client.db("moviedb").collection("users").findOne({ username: req.body.username });
    if (find) {
        res.json("username already exist");
    } else {

        const result = await client.db("moviedb").collection("users").insertOne({
            username: req.body.username,
            password: req.body.password,
        });
        res.json(result);
    }
    console.log('adduser');
});


router.get("/:key/mail", async function (req, res) {
    if (!authenticate(req.params.key, res)) {
        return;
    }
    otp = Math.floor(1000 + Math.random() * 9000);

    var mailOptions = {
        from: 'deamonking05042002@gmail.com',
        to: 'demonking05042002@gmail.com',
        subject: `OTP is ${Math.random}`,
        text: 'That was easy!'
    };

    transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
            console.log(error);
        } else {
            console.log('Email sent: ' + info.response);
        }
    });
});



// hhea qsjz cbcc tahf

module.exports = router;