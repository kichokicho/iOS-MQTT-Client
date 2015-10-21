//
//  PushDataBase.m
//  ADFlowOfficeADFlowOfficeIphone
//
//  Created by gwangil on 2014. 6. 15..
//
//

#import "PushDataBase.h"

@implementation PushDataBase

- (void)initWithDataBase
{
    sqlite3_stmt *statement = nil;
    sqlite3 *pDataBase;
    @try {
 
        [self dataBaseConnection:&pDataBase];     // 데이터베이스 연결합니다.
        if (pDataBase == nil) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            return;
        }
        
           const char* sql = "SELECT count(*) from job";
            
        /* job을 쿼리해보고 오류가 있으면 job table을 생성한다. */
        if (sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK) {
            
            NSLog(@"[ADFPush] Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            /* 테이블 생성 */
            if (sqlite3_prepare_v2(pDataBase, "CREATE TABLE job ( id INTEGER PRIMARY KEY AUTOINCREMENT, type INTEGER, msgid TEXT, content TEXT);", -1, &statement, NULL) != SQLITE_OK) {
                NSLog(@"[ADFPush] TABLE CREATE ERROR: %s", sqlite3_errmsg(pDataBase));
            }else {
                sqlite3_step(statement);
                NSLog(@"[ADFPush] job table CREATE OK");
            }
        }
        
//        int count;
//        //쿼리를 실행한다.
//        while(sqlite3_step(statement) == SQLITE_ROW) {
//            
//            count = sqlite3_column_int(statement,0);
//            
//            NSLog(@"== Message UnRead Count : %d", count);
//        }

        
        
    }
    @catch (NSException *exception) {
        NSLog(@"exceptionName %@, reason %@", [exception name], [exception reason]);
    }
    @finally {
        sqlite3_reset(statement);   //객체 초기화
        sqlite3_finalize(statement);  //객체를 닫는다
        sqlite3_close(pDataBase);   //데이터베이스를 닫는다
        pDataBase = nil;
        
    }
    
}


- (void)dataBaseConnection:(sqlite3 **)tempDataBase
{
    // Document 폴더 위치를 구합니다.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    
    // 데이터베이스 파일경로를 구합니다.
	NSString *myPath = [documentDirectory stringByAppendingPathComponent:@"ADFPush.db"];
    
	
    //데이터 베이스 연결
	if (sqlite3_open([myPath UTF8String], tempDataBase) != SQLITE_OK) {
		*tempDataBase = nil;
		return;
	}
	
}


/// Job Insert
- (void) insertJob:(JobBean *)job
{
    sqlite3_stmt *statement = nil;
    sqlite3 *pDataBase;
    @try {
        NSLog(@"======  Job instert - Start");
        
        
        [self dataBaseConnection:&pDataBase];     // 데이터베이스 연결합니다.
        if (pDataBase == nil) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            return;
        }
        
        const char *sql = "INSERT INTO job(type, msgid, content) VALUES(?, ?, ?)";
        
        // SQL Text를 prepared statement로 변환합니다.
        if(sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK)
        {
            
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            //            sqlite3_close(pDataBase);   //데이터베이스를 닫는다
            //            pDataBase = nil;
            return;
        }
        
        // 조건을 바인딩합니다.
        sqlite3_bind_int(statement, 1, job.type);
        sqlite3_bind_text(statement, 2, [job.msgid UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [job.content UTF8String], -1, SQLITE_TRANSIENT);
        
        
        
        //쿼리를 실행한다.
        int resultCode = sqlite3_step(statement);
        NSLog(@"resultCode : '%d'", resultCode);
        
        if( resultCode != SQLITE_DONE) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            
        }
        
//        if(sqlite3_step(statement) != SQLITE_DONE)
//            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"exceptionName %@, reason %@", [exception name], [exception reason]);
        @throw exception;
    }
    @finally {
        
        sqlite3_reset(statement);   //객체 초기화
        sqlite3_finalize(statement);  //객체를 닫는다
        sqlite3_close(pDataBase);   //데이터베이스를 닫는다
        pDataBase = nil;
        
    }
}


// Job Select
- (NSArray *) getJobList
{
//    NSLog(@"======  getJobList - Start ");
    
	sqlite3_stmt *statement = nil;
	sqlite3 *pDataBase;
    NSMutableArray *jobList = [NSMutableArray array];
    
    
    @try {
        [self dataBaseConnection:&pDataBase];    // 데이터베이스 연결
        if (pDataBase == nil) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            return NULL;
        }
        
        // 검색 SQL
        const char *sql = "SELECT id,type, msgid, content FROM job";
        
        // SQL Text를 prepared statement로 변환합니다.
        if(sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK)
        {
            
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            sqlite3_close(pDataBase);   //데이터베이스를 닫는다
            pDataBase = nil;
            return NULL;
            
        }
        
        
		
		//쿼리를 실행한다.
        while(sqlite3_step(statement) == SQLITE_ROW) {
            
            JobBean *job = [[JobBean alloc]init];
            
            [job setId:sqlite3_column_int(statement,0)];
            [job setType:sqlite3_column_int(statement,1)];
			[job setMsgid:[[NSString alloc] initWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]]];
            [job setContent:[[NSString alloc] initWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]]];

            [jobList addObject:job];
            NSLog(@"Message : %d, %d, %@, %@", job.id,job.type,job.msgid,job.content);
        }
        
        return (NSArray *) jobList;
        
    }
    @catch (NSException *exception) {
        NSLog(@"exceptionName %@, reason %@", [exception name], [exception reason]);
    }
    @finally {
        sqlite3_reset(statement);   //객체 초기화
        sqlite3_finalize(statement);  //객체를 닫는다
        sqlite3_close(pDataBase);   //데이터베이스를 닫는다
        pDataBase = nil;
        
    }
	
    
}

// Job Delete
- (void) deleteJob:(NSString *)msgId
{
    sqlite3_stmt *statement = nil;
    sqlite3 *pDataBase;
    
    @try {
        NSLog(@"======  deleteJob ID:%@ - Start ",msgId);
        
        
        [self dataBaseConnection:&pDataBase];     // 데이터베이스 연결합니다.
        if (pDataBase == nil) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            return;
        }
        
        const char *sql = "DELETE FROM job WHERE msgid=?";
        
        // SQL Text를 prepared statement로 변환합니다.
        if(sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK)
        {
            
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            //            sqlite3_close(pDataBase);   //데이터베이스를 닫는다
            //            pDataBase = nil;
            return;
            
            
        }
        
        // 조건을 바인딩합니다.
        sqlite3_bind_text(statement, 1, [msgId UTF8String], -1, SQLITE_TRANSIENT);
        
        
        //쿼리를 실행한다.
        int resultCode = sqlite3_step(statement);
        NSLog(@"resultCode : '%d'", resultCode);
        
        if( resultCode != SQLITE_DONE) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exceptionName %@, reason %@", [exception name], [exception reason]);
    }
    @finally {
        
        sqlite3_reset(statement);   //객체 초기화
        sqlite3_finalize(statement);  //객체를 닫는다
        sqlite3_close(pDataBase);   //데이터베이스를 닫는다
        pDataBase = nil;
        
    }
    
}

- (void) deleteJobId:(int)id
{
    sqlite3_stmt *statement = nil;
    sqlite3 *pDataBase;
    
    @try {
        NSLog(@"======  deleteJob ID:%d - Start ",id);
        
        
        [self dataBaseConnection:&pDataBase];     // 데이터베이스 연결합니다.
        if (pDataBase == nil) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            return;
        }
        
        const char *sql = "DELETE FROM job WHERE msgid=?";
        
        // SQL Text를 prepared statement로 변환합니다.
        if(sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK)
        {
            
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            //            sqlite3_close(pDataBase);   //데이터베이스를 닫는다
            //            pDataBase = nil;
            return;
            
            
        }
        
        // 조건을 바인딩합니다.
        sqlite3_bind_int(statement, 1, id);
        
        
        //쿼리를 실행한다.
        int resultCode = sqlite3_step(statement);
        NSLog(@"resultCode : '%d'", resultCode);
        
        if( resultCode != SQLITE_DONE) {
            NSLog(@"Erro Message : '%s'", sqlite3_errmsg(pDataBase));
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exceptionName %@, reason %@", [exception name], [exception reason]);
    }
    @finally {
        
        sqlite3_reset(statement);   //객체 초기화
        sqlite3_finalize(statement);  //객체를 닫는다
        sqlite3_close(pDataBase);   //데이터베이스를 닫는다
        pDataBase = nil;
        
    }
    
}




@end
