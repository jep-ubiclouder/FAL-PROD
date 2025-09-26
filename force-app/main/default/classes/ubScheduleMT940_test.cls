@isTest
private class ubScheduleMT940_test {
    @isTest
     static void  ubScheduleMT940_test() {
        Test.StartTest();
        ubScheduleMT940 testsche = new ubScheduleMT940 ();
        String sch = '0 0 23 * * ?';
        system.schedule('Test status Check', sch, testsche );
        Test.stopTest();
    }
}

//ubScheduleMT940