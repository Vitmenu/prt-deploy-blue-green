import express from "express";

const app = express();
const port = 3000;

app.use((req, res, next) => {
    if (req.hostname.includes("prt-nginx-zero-downtime-nodejs")) {
        next();
    } else {
        res.send('Invalid hostname!');
    };
})

app.use((req, res) => {
    console.log(req.headers);

    res.send('blue first');

});


app.listen(port, () => console.log(`App nodejs-blue listens to port ${port}`));