# Reading data from the blockchain


Three types of accounts on Solana

- Data accounts - these store data
- Program accounts - these store executable programs(AkA smart contracts)
- Native accounts - these are for core blockchain function like Stake, Vote.

Data account have two further types

- System owned accounts
- PDA (Program derived Address) accounts

Acount have a number of fields

- lamports: the number of lamports owned by this account.
- owner: the program owner of this account.
- executable: whether this account can process instructions (is executable)
- data: the raw data byte array stored by this account
- rent_epoch: the next epoch that this account will owe rent

