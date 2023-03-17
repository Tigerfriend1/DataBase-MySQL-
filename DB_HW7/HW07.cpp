//macos환경을 사용하여 진행하였습니다.
//쿼리문 정상동작 확인하였습니다.
#include <stdlib.h>
#include <iostream>
#include <string>
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/mysql_connection.h"
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/mysql_driver.h"
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/cppconn/driver.h"
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/cppconn/exception.h"
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/cppconn/resultset.h"
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/cppconn/statement.h"
#include "/usr/local/mysql-connector-c++-8.0.31/include/jdbc/cppconn/prepared_statement.h"

using namespace std;

void ShowSupplier(sql::PreparedStatement *pstmt, sql::ResultSet *res, sql::Connection *con, string city);


int main() {
    try{
        int opt, courseId;
        sql::mysql::MySQL_Driver *driver;
        sql::Connection *con;
        sql::Statement *stmt;
        sql::ResultSet *res;
        sql::PreparedStatement *pstmt;
        driver = sql::mysql::get_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306","root","1353");
        con->setSchema("HW07");

        cout << "Let's start!!"<<endl;
        string city;
        while (1){
            cout<<"\n\n\n===This is Find the name of a supplier that supplies all parts made in a particular city.====\n\n\n";
            cout<<"Please Enter which you want to find city"<<endl;
            cin>>city;
            ShowSupplier(pstmt,res,con,city);

        }
     }
    catch (sql::SQLException &e){
        cout << "# ERR: SQLException in " << __FILE__;
        cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
        cout << "# ERR: " << e.what();
        cout << " MySQL error code: "<< e.getErrorCode();
        cout << ", SQLState: " << e.getSQLState() << ")" << endl;
    }
    cout << endl;
    return EXIT_SUCCESS;


}



void ShowSupplier(sql::PreparedStatement *pstmt, sql::ResultSet *res, sql::Connection *con, string city){
    pstmt = con->prepareStatement("select sx.sname from s sx where not exists (select * from p px where px.city=? and not exists (select * from sp spx where spx.sno = sx.sno and spx.pno = px.pno));");
    pstmt->setString(1,city);
    res = pstmt->executeQuery();
    
    cout<<"\t_______________________________"<<endl;
    while (res->next())
    cout<<"\t|\t\t"<<res->getString("sname")<<"\t|"<<endl;
    delete res;
    delete pstmt;
}