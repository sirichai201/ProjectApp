require('dotenv').config();
const express = require('express');
const Web3 = require('web3');


const app = express();
const web3 = new Web3('http://192.168.1.2:7545');




const contractABI = [
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "string",
        "name": "reason",
        "type": "string"
      }
    ],
    "name": "ErrorOccurred",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "admin",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "name": "users",
    "outputs": [
      {
        "internalType": "bytes32",
        "name": "passwordHash",
        "type": "bytes32"
      },
      {
        "internalType": "enum UniversityAuthentication.Role",
        "name": "role",
        "type": "uint8"
      },
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "_username",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_password",
        "type": "string"
      },
      {
        "internalType": "uint8",
        "name": "_role",
        "type": "uint8"
      }
    ],
    "name": "createUser",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "_username",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_oldPassword",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_newPassword",
        "type": "string"
      }
    ],
    "name": "changePassword",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "_username",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_password",
        "type": "string"
      }
    ],
    "name": "login",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "_newUsername",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_newPassword",
        "type": "string"
      }
    ],
    "name": "setAdminCredentials",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
];  // ใช้ ABI เดิม
const contractAddress = "0x0f686C7422C31e0f31061dE2dCE272e16645Ec5B";
const contract = new web3.eth.Contract(contractABI, contractAddress);
const OWNER_ADDRESS = process.env.OWNER_ADDRESS;
const GAS_LIMIT = 200000;
const GAS_PRICE = '20000000000';

app.use(express.json());

const handleErrors = (res, error) => {
    console.error(error);
    res.status(400).send(error.message);
}

app.post('/createUser', async (req, res) => {
    const { username, password, role } = req.body;
    try {
        const result = await contract.methods.createUser(username, password, role).send({ from: OWNER_ADDRESS, gas: GAS_LIMIT, gasPrice: GAS_PRICE });
        res.send(result);
    } catch (error) {
        handleErrors(res, error);
    }
});

app.put('/changePassword', async (req, res) => {
    const { username, newPassword } = req.body;
    try {
        const result = await contract.methods.changePassword(username, newPassword).send({ from: OWNER_ADDRESS, gas: GAS_LIMIT, gasPrice: GAS_PRICE });
        res.send(result);
    } catch (error) {
        handleErrors(res, error);
    }
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        role = await contract.methods.login(username, password).call();
        res.send({ role });
    } catch (error) {
        handleErrors(res, error);
    }
});

app.listen(3000, () => {
    console.log('Server started on http://localhost:3000');
});



