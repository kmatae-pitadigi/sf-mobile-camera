public with sharing class pdCamera {
    /**
     * 写真を添付するカスタムオブジェクトの対象レコード
     */
    private final Test__c record;

    // 添付ファイル
    /**
     * カメラで撮影したイメージ
     */
    public ContentVersion contentVersion { get; set; }

    /**
     * コンストラクタ
     */
    public pdCamera(ApexPages.StandardController stdController) {
        // 写真を添付するカスタムオブジェクトの対象レコードを設定する
        this.record = (Test__c)stdController.getRecord();

        // カメラを撮影したイメージを作成する(枠だけ)
        this.contentVersion = new ContentVersion();
    }

    /**
     * カメラで撮影したイメージを対象レコードのファイルとして保存する
     */
    public PageReference save() {
        // 添付ファイルの情報を設定、保存する
        this.contentVersion.PathOnClient = this.contentVersion.Title;
        insert contentVersion;

        // 登録したファイルのドキュメントIDを取得する
        Id docId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion.Id].ContentDocumentId;
        // レコードとドキュメントをリンクする
        ContentDocumentLink cde = new ContentDocumentLink();
        // リンクするドキュメントIDを設定する
        cde.ContentDocumentId = docId;
        // 添付ファイルとしてリンクするオブジェクトのレコードIDを設定する
        cde.LinkedEntityId = record.Id;
        cde.ShareType = 'V';
        insert cde;

        // 対象レコードのURLを返す
        return new PageReference('/' + record.Id);
    }
}
