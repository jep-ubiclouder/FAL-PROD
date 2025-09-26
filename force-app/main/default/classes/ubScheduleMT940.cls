global  with sharing class ubScheduleMT940 implements Schedulable {
    global void  execute (SchedulableContext ctx) {
         ubLaunchPaymentBuffer.launch();
    }
}