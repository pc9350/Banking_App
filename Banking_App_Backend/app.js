const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const app = express();
const PORT = process.env.PORT || 3000;
const { MongoClient, ServerApiVersion } = require('mongodb');
const uri = "mongodb+srv://sayeeduddin:hello@test.pkxcqvn.mongodb.net/?retryWrites=true&w=majority";
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

// V2 of API schema
/*
const AccountSchema = new mongoose.Schema({
  accountNumber: { type: String, unique: true },
  joinDate: { type: Date, default: Date.now },
  rewardTypeLastRedeemed: String,
  xpAmount: { type: Number, default: 0 },
  milesAmount: { type: Number, default: 0 },
  walmartAmount: { type: Number, default: 0 },
  amazonAmount: { type: Number, default: 0 },
  lastRedeemTime: { type: Date, default: null },
});*/

const AccountSchema = new mongoose.Schema({
  accountNumber: { type: String, unique: true },
  name: String,
  password: String,
  joinDate: { type: Date, default: Date.now },
  rewardTypeLastRedeemed: String,
  xpAmount: { type: Number, default: 0 },
  level: { type: Number, default: 1 },
  checkingAmount: { type: Number, default: Math.floor(Math.random() * 10000) + 1000 },
  savingsAmount: { type: Number, default: Math.floor(Math.random() * 50000) + 5000 },
  miles: { type: Number, default: 0 },
  walmartCredits: { type: Number, default: 0 },
  amazonCredits: { type: Number, default: 0 },
  targetCredits: { type: Number, default: 0 },
});

// Create mongoose model
const Account = mongoose.model('Account', AccountSchema);

// Middleware to parse JSON requests
app.use(bodyParser.json());

// Define routes

// Create a new account
/*
app.post('/api/account', async (req, res) => {
  try {
    const newAccount = new Account(req.body);
    await newAccount.save();
    res.json(newAccount);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
*/

// Create an Account with random data
app.post('/api/account/createRandomAccount', async (req, res) => {
  try {
    const { name, password } = req.body;

    const newAccount = new Account({
      accountNumber: Math.random().toString(36).substring(7),
      name,
      password,
    });

    const savedAccount = await newAccount.save();
    res.json(savedAccount);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/account/changeXP', async (req, res) => {
  try {
    const { accountNumber, password, xpAmount } = req.body;
    const account = await Account.findOneAndUpdate(
      { accountNumber, password },
      { xpAmount },
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found or password incorrect' });
    }

    res.json({ xpAmount: account.xpAmount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


app.post('/api/account/increaseLevel', async (req, res) => {
  try {
    const { accountNumber, password } = req.body;
    const account = await Account.findOneAndUpdate(
      { accountNumber, password },
      { $inc: { level: 1 } },
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found or password incorrect' });
    }

    res.json({ level: account.level });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/account/increaseCapitalOneMiles', async (req, res) => {
  try {
    const { accountNumber, password, miles } = req.body;
    const account = await Account.findOneAndUpdate(
      { accountNumber, password },
      { $inc: { miles } },
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found or password incorrect' });
    }

    res.json({ miles: account.miles });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/account/increaseWalmartCredits', async (req, res) => {
  try {
    const { accountNumber, password, walmartCredits } = req.body;
    const account = await Account.findOneAndUpdate(
      { accountNumber, password },
      { $inc: { walmartCredits } },
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found or password incorrect' });
    }

    res.json({ walmartCredits: account.walmartCredits });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/account/increaseAmazonCredits', async (req, res) => {
  try {
    const { accountNumber, password, amazonCredits } = req.body;
    const account = await Account.findOneAndUpdate(
      { accountNumber, password },
      { $inc: { amazonCredits } },
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found or password incorrect' });
    }

    res.json({ amazonCredits: account.amazonCredits });
  } catch (error) {
    res.status(500).json({ error: error.message});
  }
});

// Increase Target Credits
app.post('/api/account/increaseTargetCredits', async (req, res) => {
  try {
    const { accountNumber, password, targetCredits } = req.body;
    const account = await Account.findOneAndUpdate(
      { accountNumber, password },
      { $inc: { targetCredits } },
      { new: true }
    );

    if (!account) {
      return res.status(404).json({ error: 'Account not found or password incorrect' });
    }

    res.json({ targetCredits: account.targetCredits });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve XP Amount
app.get('/api/account/:accountNumber/xp', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({ xpAmount: account.xpAmount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve Level
app.get('/api/account/:accountNumber/level', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({ level: account.level });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve Capital One Miles
app.get('/api/account/:accountNumber/capitalOneMiles', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({ miles: account.miles });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve Walmart Credits
app.get('/api/account/:accountNumber/walmartCredits', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({ walmartCredits: account.walmartCredits });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve Amazon Credits
app.get('/api/account/:accountNumber/amazonCredits', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({ amazonCredits: account.amazonCredits });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Retrieve Target Credits
app.get('/api/account/:accountNumber/targetCredits', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json({ targetCredits: account.targetCredits });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update XP without requiring password
app.post('/api/account/changeXPWithoutPassword', async (req, res) => {
  try {
    const { accountNumber, xpAmount } = req.body;
    
    // Find the account by account number
    const account = await Account.findOne({ accountNumber });

    // Check if the account exists
    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    // Update the XP amount
    account.xpAmount = xpAmount;

    // Save the updated account
    const updatedAccount = await account.save();

    res.json({ xpAmount: updatedAccount.xpAmount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Increase level by a specified amount without requiring password
app.post('/api/account/increaseLevelByAmountWithoutPassword', async (req, res) => {
  try {
    const { accountNumber, level } = req.body;
    
    // Find the account by account number
    const account = await Account.findOne({ accountNumber });

    // Check if the account exists
    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    // Update the level by the specified amount
    account.level = level;

    // Save the updated account
    const updatedAccount = await account.save();

    res.json({ level: updatedAccount.level });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Display all information for a given account number
app.get('/api/account/:accountNumber', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    res.json(account);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});















// VERSION 1 Implementation 
/*
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

// Increase XP amount by 50 for a specific account number
app.post('/api/account/:accountNumber/increaseXP', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    // Increase XP by 50
    const updatedXP = account.xpAmount + 50;

    // Update account with the increased XP amount
    await Account.updateOne({ accountNumber: req.params.accountNumber }, { xpAmount: updatedXP });

    res.json({ xpAmount: updatedXP });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Increase XP amount by 50 for a specific account number
app.post('/api/account/:accountNumber/increaseMiles', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    // Increase XP by 50
    const updatedMiles = account.milesAmount + 50;

    // Update account with the increased XP amount
    await Account.updateOne({ accountNumber: req.params.accountNumber }, { milesAmount: updatedXP });

    res.json({ xpAmount: updatedMiles });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Increase XP amount by 50 for a specific account number
app.post('/api/account/:accountNumber/increaseXP', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    // Increase XP by 50
    const updatedXP = account.xpAmount + 50;

    // Update account with the increased XP amount
    await Account.updateOne({ accountNumber: req.params.accountNumber }, { xpAmount: updatedXP });

    res.json({ xpAmount: updatedXP });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
// Increase XP amount by 50 for a specific account number
app.post('/api/account/:accountNumber/increaseXP', async (req, res) => {
  try {
    const account = await Account.findOne({ accountNumber: req.params.accountNumber });

    if (!account) {
      return res.status(404).json({ error: 'Account not found' });
    }

    // Increase XP by 50
    const updatedXP = account.xpAmount + 50;

    // Update account with the increased XP amount
    await Account.updateOne({ accountNumber: req.params.accountNumber }, { xpAmount: updatedXP });

    res.json({ xpAmount: updatedXP });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



// ... (other routes)
*/
// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
