package entity;
import java.time.LocalDate;
public class Account {

    private int id;
    private String email;
    private String userName;
    private String fullName;
    private Department department;
    private Position position;
    private LocalDate createDate;
    private Group[] groups;

    /*  Question 2:
    Tạo constructor cho Account:
    a) Không có parameters
    b) Có các parameter là id, Email, Username, FirstName,
    LastName (với FullName = FirstName + LastName)
    c) Có các parameter là id, Email, Username, FirstName,
    LastName (với FullName = FirstName + LastName) và
    Position của User, default createDate = now
    d) Có các parameter là id, Email, Username, FirstName,
    LastName (với FullName = FirstName + LastName) và
    Position của User, createDate
    Khởi tạo 1 Object với mỗi constructor ở trên
   */

    //     A. constructor k co parameter
    public Account(){

    }
    //    B. constructor co parameter
    public Account(int id, String email, String userName, String firstName, String lastName) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = firstName + lastName ;
    }
//   C. Có các parameter là id, Email, Username, FirstName,
//      LastName (với FullName = FirstName + LastName) và
//      Position của User, default createDate = now

    public Account(int id, String email, String userName, String firstName, String lastName, Position position) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = firstName + lastName ;
        this.position = position;
        this.createDate = LocalDate.now();
    }
//    d) Có các parameter là id, Email, Username, FirstName,
//    LastName (với FullName = FirstName + LastName) và
//    Position của User, createDate

    public Account(int id, String email, String userName, String firstName, String lastName,Position position,LocalDate createDate) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = firstName + lastName ;
        this.position = position;
        this.createDate = createDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Position getPosition() {
        return position;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public LocalDate getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDate createDate) {
        this.createDate = createDate;
    }

    public Group[] getGroups() {
        return groups;
    }

    public void setGroups(Group[] groups) {
        this.groups = groups;
    }
}
