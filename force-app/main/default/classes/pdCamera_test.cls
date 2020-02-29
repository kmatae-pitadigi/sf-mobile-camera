@isTest
public class pdCamera_test {
    @isTest
    public static void save_test() {
        StaticResource sr = [SELECT Id,Body FROM StaticResource WHERE Name='pdCamera'];

        Blob image = sr.Body;

        Test__c test = new Test__c();
        test.Name = 'test';
        insert test;

        ApexPages.StandardController stdController = new ApexPages.StandardController(test);

        pdCamera c = new pdCamera(stdController);

        c.contentVersion.VersionData = image;
        c.contentVersion.Title = 'image.png';

        c.save();
    }
}
