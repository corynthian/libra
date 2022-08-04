//# init --validators Alice

//# run --admin-script --signers DiemRoot Alice
script {
    use DiemFramework::Audit;
    use DiemFramework::ValidatorConfig;
    // use DiemFramework::AutoPay;
    // use DiemFramework::TowerState;
    // use DiemFramework::GAS::GAS;
    use DiemFramework::Vouch;
    use DiemFramework::Testnet;
    use DiemFramework::Debug::print;

    fun main(vm: signer, _alice_sig: signer) {
        Testnet::remove_testnet(&vm);
        // // Test audit function val_audit_passing satisfying all conditions
        assert!(ValidatorConfig::is_valid(@Alice), 7257001);
        
        // // operator has gas from genesis
        // let oper = ValidatorConfig::get_operator(@Alice);
        // assert!(DiemAccount::balance<GAS>(oper) == 1000000, 7357007003002);
        
        // // enable autopay
        // assert!(!AutoPay::is_enabled(@Alice), 7357007003003);
        // AutoPay::enable_autopay(&alice_sig);
        // assert!(AutoPay::is_enabled(@Alice), 7357007003004);

        // assert!(TowerState::is_init(@Alice), 7357007003005);
        assert!(!Audit::val_audit_passing(@Alice), 7357002);

        // // audit must pass
        print(&Vouch::unrelated_buddies_above_thresh(@Alice));
        print(&Audit::val_audit_passing(@Alice));
    }
}