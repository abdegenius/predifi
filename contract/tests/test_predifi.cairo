use starknet::{ContractAddress, contract_address_const, ClassHash};

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

//use starknet::{ContractAddress, SyscallResultTrait};
//use core::result::ResultTrait;
//use core::byte_array::ByteArray;

use contract::base::types::{PoolDetails, Pool, Status, Category};
use contract::interfaces::ipredifi::{IPredifiDispatcher, IPredifiDispatcherTrait};

fn owner() -> ContractAddress {
    'owner'.try_into().unwrap()
}
fn deploy_predifi() -> IPredifiDispatcher{
    let contract_class = declare("Predifi").unwrap().contract_class();

    let mut calldata = array![];
    owner().serialize(ref calldata);

    let (contract_address, _) = contract_class.deploy(@calldata).unwrap();
    IPredifiDispatcher{contract_address}

}


#[test]
    fn test_create_pool() {
        let contract = deploy_predifi();
        let result = contract.create_pool(
            'Example Pool',
            Pool::WinBet,
            "A simple betting pool",
            "image.png",
            "event.com/details",
            1710000000,
            1710003600,
            1710007200,
            'Team A',
            'Team B',
            100,
            10000,
            5,
            false,
            Category::Sports,
        );

        assert!(result == true, "not created");
    }

// // Add the mock contract at the top of your test file
// #[starknet::interface]
// trait IRandomness<TContractState> {
//     fn request_random(
//         ref self: TContractState,
//         seed: felt252,
//         callback_address: ContractAddress,
//         callback_fee_limit: felt252,
//         publish_delay: felt252,
//         num_words: felt252,
//         calldata: Array<felt252>,
//     );
// }

// #[starknet::contract]
// mod MockRandomness {
//     use super::IRandomness;
//     use starknet::{ContractAddress, get_caller_address, syscalls::call_contract_syscall};
//     use core::array::ArrayTrait;
//     use starknet::SyscallResultTrait; // Add this import

//     #[storage]
//     struct Storage {}

//     #[abi(embed_v0)] // Changed from external to abi
//     impl RandomnessImpl of IRandomness<ContractState> {
//         fn request_random(
//             ref self: ContractState,
//             seed: felt252,
//             callback_address: ContractAddress,
//             callback_fee_limit: felt252,
//             publish_delay: felt252,
//             num_words: felt252,
//             mut calldata: Array<felt252>,
//         ) {
//             let caller = get_caller_address();

//             call_contract_syscall(
//                 callback_address,
//                 'receive_random_words',
//                 array![caller.into(), seed, 1, 1234567890].span(),
//             )
//                 .unwrap_syscall(); // Changed to unwrap_syscall
//         }
//     }
// }

// pub mod Accounts {
//     use starknet::ContractAddress;
//     use core::traits::TryInto;

//     pub fn zero() -> ContractAddress {
//         0x0000000000000000000000000000000000000000.try_into().unwrap()
//     }

//     pub fn owner() -> ContractAddress {
//         'owner'.try_into().unwrap()
//     }

//     pub fn strkaddress() -> ContractAddress {
//         'strkaddress'.try_into().unwrap()
//     }

//     pub fn account2() -> ContractAddress {
//         'account2'.try_into().unwrap()
//     }

//     pub fn randomness_address() -> ContractAddress {
//         'randomness_address'.try_into().unwrap()
//     }

//     pub fn predifi_token() -> ContractAddress {
//         'predifi_token'.try_into().unwrap()
//     }
// }

// fn deploy_util(contract_name: ByteArray, constructor_calldata: Array<felt252>) -> ContractAddress {
//     let contract = declare(contract_name).unwrap().contract_class();
//     let (contract_address, _) = contract.deploy(@constructor_calldata).unwrap();
//     contract_address
// }

// #[test]
// fn contract_deployed_successfully() {
//     let mock_randomness_address = deploy_util("MockRandomness", array![]);

//     // deploying the student_registry contract
//     let mut predifi_call_data: Array<felt252> = array![
//         Accounts::owner().into(),
//         Accounts::strkaddress().into(),
//         mock_randomness_address.into(),
//         Accounts::predifi_token().into(),
//     ];
//     let predifi_contract_address: ContractAddress = deploy_util("Predifi", predifi_call_data);
//     let predifi_instance = IPredifiDispatcher { contract_address: predifi_contract_address };
// }

// #[test]
// fn create_pool_successfully() {
//     let mock_randomness_address = deploy_util("MockRandomness", array![]);

//     let mut predifi_call_data: Array<felt252> = array![
//         Accounts::owner().into(),
//         Accounts::strkaddress().into(),
//         mock_randomness_address.into(),
//         Accounts::predifi_token().into(),
//     ];
//     let predifi_contract_address: ContractAddress = deploy_util("Predifi", predifi_call_data);
//     let predifi_instance = IPredifiDispatcher { contract_address: predifi_contract_address };
//     let result = predifi_instance
//         .create_pool(
//             poolName: 'Test Pool',
//             poolType: Pool::WinBet,
//             poolDescription: "Test Description",
//             poolImage: "test.jpg",
//             poolEventSourceUrl: "https://test.com",
//             poolStartTime: 1700000000,
//             poolLockTime: 1700001000,
//             poolEndTime: 1700002000,
//             option1: 'Team A',
//             option2: 'Team B',
//             minBetAmount: 1,
//             maxBetAmount: 100,
//             creatorFee: 5,
//             isPrivate: false,
//             category: Category::Sports,
//         );

//     assert_eq!(result, true, "Result is supposed to be true");
// }

// #[test]
// fn get_all_pools_test() {
//     let mock_randomness_address = deploy_util("MockRandomness", array![]);

//     let mut predifi_call_data: Array<felt252> = array![
//         Accounts::owner().into(),
//         Accounts::strkaddress().into(),
//         mock_randomness_address.into(),
//         Accounts::predifi_token().into(),
//     ];

//     let predifi_contract_address: ContractAddress = deploy_util("Predifi", predifi_call_data);
//     let predifi_instance = IPredifiDispatcher { contract_address: predifi_contract_address };
//     let result = predifi_instance
//         .create_pool(
//             poolName: 'Test Pool',
//             poolType: Pool::WinBet,
//             poolDescription: "Test Description",
//             poolImage: "test.jpg",
//             poolEventSourceUrl: "https://test.com",
//             poolStartTime: 1700000000,
//             poolLockTime: 1700001000,
//             poolEndTime: 1700002000,
//             option1: 'Team A',
//             option2: 'Team B',
//             minBetAmount: 1,
//             maxBetAmount: 100,
//             creatorFee: 5,
//             isPrivate: false,
//             category: Category::Sports,
//         );

//     assert_eq!(result, true, "Result is supposed to be true");
//     let pools = predifi_instance.get_active_pools();
//     println!("Pools: {:?}", pools);
//     // assert_eq!(pools.len(), 1, "Should have one pool");
// // let pool = pools.at(0);
// // assert_eq!(pool.poolName, 'Test Pool', "Pool name mismatch");
// // assert_eq!(pool.poolType, Pool::WinBet, "Pool type mismatch");
// // assert_eq!(pool.status, Status::Active, "Pool status mismatch");
// // assert_eq!(pool.category, 'Sports', "Category mismatch");
// }
