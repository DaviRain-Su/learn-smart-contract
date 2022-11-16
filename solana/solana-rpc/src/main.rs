use std::str::FromStr;

use solana_client::rpc_client::RpcClient;
use solana_program::pubkey::Pubkey;
use solana_sdk::signer::keypair::Keypair;
const SOLANA_TOKEN_PRECISION: u64 = 1000_000_000;

fn main() -> anyhow::Result<()> {
    let owner_keypair = Keypair::new();
    println!("owner_keypair: {:#?}", owner_keypair);

    let _devnet_url = "https://rpc.ankr.com/solana_devnet".to_string();
    let main_url = "https://rpc.ankr.com/solana".to_string();

    let client = RpcClient::new(main_url);
    let address_pubkey = Pubkey::from_str("sb3bUnVTEcKusCEu8nxVnUZu1NPyCx5xP9pxV8RNa2y")?;

    let balance = client.get_balance(&address_pubkey)?;

    let _first = balance / SOLANA_TOKEN_PRECISION;
    let _second = balance % SOLANA_TOKEN_PRECISION;

    println!("💰Address: {}, Balace : {}", address_pubkey, balance);

    Ok(())
}
