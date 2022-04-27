//! account: alice, 1, 0, validator

//! new-transaction
//! sender: alice
script {
    use DiemFramework::TowerState;

    fun main(sender: signer) {
        // Alice is the only one that can update her mining stats. 
        // Hence this first transaction.

        TowerState::test_helper_mock_mining(&sender, 0);
        assert!(TowerState::get_count_in_epoch(@Alice) == 0, 7357300101011000);
    }
}
//check: EXECUTED


//! new-transaction
//! sender: diemroot
script {
    use DiemFramework::Stats;
    use Std::Vector;
    use DiemFramework::Cases;
    
    fun main(sender: signer) {
        // todo: change name to Mock epochs
        // TowerState::test_helper_set_epochs(sender, 5);
        let voters = Vector::singleton<address>(@Alice);
        let i = 1;
        while (i < 16) {
            // Mock the validator doing work for 15 blocks, and stats being updated.
            Stats::process_set_votes(&sender, &voters);
            i = i + 1;
        };

        assert!(Cases::get_case(&sender, @Alice, 0 , 15) == 2, 7357300103011000);
    }
}
//check: EXECUTED
