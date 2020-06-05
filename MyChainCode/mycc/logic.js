'use strict';
const { Contract} = require('fabric-contract-api');

class testContract extends Contract {



   async queryData(ctx,orcid) {
   
    let dataAsBytes = await ctx.stub.getState(orcid); 
    if (!dataAsBytes || dataAsBytes.toString().length <= 0) {
      throw new Error('Student with this Id does not exist: ');
       }
      let data=JSON.parse(dataAsBytes.toString());
      
      return JSON.stringify(data);
     }

   async addData(ctx,orcid,subject1,subject2,subject3) {
   
    let data={
       subj1:subject1,
       subj2:subject2,
       subj3:subject3
       };

    await ctx.stub.putState(orcid,Buffer.from(JSON.stringify(data))); 
    
    console.log('Student data added To the ledger Succesfully..');
    
  }

   async deleteData(ctx,orcid) {
   

    await ctx.stub.deleteState(orcid); 
    
    console.log('Student data deleted from the ledger Succesfully..');
    
    }
}

module.exports=testContract;
