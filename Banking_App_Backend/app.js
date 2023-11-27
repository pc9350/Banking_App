const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const app = express();
const PORT = process.env.PORT || 3000;
const { MongoClient, ServerApiVersion } = require('mongodb');
const uri = "mongodb+srv://sayeeduddin:hello@test.pkxcqvn.mongodb.net/?retryWrites=true&w=majority";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(uri, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});

mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true, serverSelectionTimeoutMS: 30000 });

async function run() {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await client.connect();
    // Send a ping to confirm a successful connection
    await client.db("admin").command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
}
run().catch(console.dir);
// Define schemas
const AccountSchema = new mongoose.Schema({
  accountNumber: { type: String, unique: true },
  joinDate: { type: Date, default: Date.now },
  rewardTypeLastRedeemed: String,
  xpAmount: { type: Number, default: 0 },
  lastRedeemTime: { type: Date, default: null },
});

// Create mongoose model
const Account = mongoose.model('Account', AccountSchema);

// Middleware to parse JSON requests
app.use(bodyParser.json());

// Define routes

// Create a new account
app.post('/api/account', async (req, res) => {
  try {
    const newAccount = new Account(req.body);
    await newAccount.save();
    res.json(newAccount);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get account details by account number
app.get('/api/account/:accountNumber', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({
      accountNumber: account.accountNumber,
      joinDate: account.joinDate,
      rewardTypeLastRedeemed: account.rewardTypeLastRedeemed,
      xpAmount: account.xpAmount,
      lastRedeemTime: account.lastRedeemTime,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update account details by account number
app.put('/api/account/:accountNumber', async (req, res) => {
  try {
    const account = await Account.findOneAndUpdate(
      { accountNumber: req.params.accountNumber },
      req.body,
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({
      accountNumber: account.accountNumber,
      joinDate: account.joinDate,
      rewardTypeLastRedeemed: account.rewardTypeLastRedeemed,
      xpAmount: account.xpAmount,
      lastRedeemTime: account.lastRedeemTime,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/account/:accountNumber/randomData', async (req, res) => {
    try {
      const account = await Account.findOne({ accountNumber: req.params.accountNumber });
  
      if (!account) {
        return res.status(404).json({ error: 'Account not found' });
      }
  
      // Generate random data
      const randomJoinDate = new Date(Date.now() - Math.floor(Math.random() * 10000000000));
      const rewardTypes = ['Walmart', 'Miles', 'Amazon'];
      const randomRewardType = rewardTypes[Math.floor(Math.random() * rewardTypes.length)];
      const randomXpAmount = Math.floor(Math.random() * 1000);
      const randomLastRedeemTime = new Date(Date.now() - Math.floor(Math.random() * 10000000000));
  
      // Update account with random data
      const updatedAccount = await Account.findOneAndUpdate(
        { accountNumber: req.params.accountNumber },
        {
          joinDate: randomJoinDate,
          rewardTypeLastRedeemed: randomRewardType,
          xpAmount: randomXpAmount,
          lastRedeemTime: randomLastRedeemTime,
        },
        { new: true }
      );
  
      res.json(updatedAccount);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  })

// Retrieve date joined for a specific account number
app.get('/api/account/:accountNumber/joinDate', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    const joinDate = account.joinDate;
    res.json({ joinDate });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve type of reward last redeemed for a specific account number
app.get('/api/account/:accountNumber/rewardType', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    const rewardType = account.rewardTypeLastRedeemed;
    res.json({ rewardType });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve XP amount for a specific account number
app.get('/api/account/:accountNumber/xp', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    const xpAmount = account.xpAmount;
    res.json({ xpAmount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve time since last reward redeemed for a specific account number
app.get('/api/account/:accountNumber/lastRedeemTime', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    const lastRedeemTime = account.lastRedeemTime;
    res.json({ lastRedeemTime });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



// ... (other routes)

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
