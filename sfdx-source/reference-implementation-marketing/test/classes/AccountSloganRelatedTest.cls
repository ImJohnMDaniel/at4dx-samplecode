/**
 * Copyright (c) 2020, John M. Daniel, John Storey
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the John M. Daniel, nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

@isTest 
private class AccountSloganRelatedTest 
{
    @isTest 
    static void givenNewAccountWhenCreatedWithFishNameThenSloganIsDefaulted()
    {
        // given

        // when
        Test.startTest();
        Account bluefishAccount = new Account();

        bluefishAccount.name = 'bluefish';
        
        insert bluefishAccount;

        Test.stopTest();

        // then
        
        list<Account> accountRecordsQueried = AccountsSelector.newInstance().selectById( new Set<id>{ bluefishAccount.Id } );

        System.assert( ! accountRecordsQueried.isEmpty() );
        System.assert( accountRecordsQueried.size() == 1 );

        Account accountRecordQueried = accountRecordsQueried[0];

        System.assert( String.isNotBlank( accountRecordQueried.Slogan__c ) );
        
    }

    @isTest 
    static void givenNewAccountWhenCreatedWithFishNameThenSelectorMethodInjection()
    {
        // given
        String slogan = 'The Big Blue Fish is a fishy business';

        Account bluefishAccount = new Account();

        bluefishAccount.Id = fflib_IDGenerator.generate( Account.SObjectType );
        bluefishAccount.name = 'bluefish';
        bluefishAccount.slogan__c = slogan;

        fflib_ApexMocks mocks = new fflib_ApexMocks();

        IAccountsSelector mockAccountsSelector = (IAccountsSelector) mocks.mock( IAccountsSelector.class );

        mocks.startStubbing();

        SelectBySloganSelectorMethod.Parameters queryParams = new SelectBySloganSelectorMethod.Parameters();

        queryParams.sloganNameSet = new Set<String>{ slogan };

        // when
        Test.startTest();
        
        system.debug( AccountsSelector.newInstance().selectInjection( SelectBySloganSelectorMethod.class, queryParams) );

        Test.stopTest();

        // then
        
        // list<Account> accountRecordsQueried = AccountsSelector.newInstance().selectById( new Set<id>{ bluefishAccount.Id } );

        // System.assert( ! accountRecordsQueried.isEmpty() );
        // System.assert( accountRecordsQueried.size() == 1 );

        // Account accountRecordQueried = accountRecordsQueried[0];

        // System.assert( String.isNotBlank( accountRecordQueried.Slogan__c ) );
    }



}
