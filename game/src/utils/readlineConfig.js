const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const question = (string) => {
    return new Promise((resolve) => {
        rl.question(string, (answer) => {
            resolve(answer);
        });
    });
};

module.exports = {
    rl,
    question
};