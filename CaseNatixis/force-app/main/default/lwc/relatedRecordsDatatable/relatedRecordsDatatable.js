import { LightningElement, api, wire, track } from 'lwc';
import getRecordList from '@salesforce/apex/RelatedRecordsTableController.getRecordList';

export default class relatedRecordsDatatable extends LightningElement {

    wiredAccounts;
    @api recordId;
    @track error;
    @track recordList;

    columns = [
        { label: 'Name', fieldName: 'recordName' },
        { label: 'CreatedDate', fieldName: 'createdDate', type: 'date' },
    ];

    @wire(getRecordList, { recId: '$recordId' })
    wiredAccounts({
        data,
        error
    }) {
        if (data) {
            console.log('data: 2');
            console.log(data);           
            this.recordList = data;
        } else if (error) {
            console.log('error==> ', error);
            this.error = error;
        } 
    }
}