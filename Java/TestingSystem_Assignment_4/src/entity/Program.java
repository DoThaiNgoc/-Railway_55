package entity;

import entity.Account;
import entity.Department;
import entity.Group;
import entity.Position;
import entity.Position.PositionName;
import java.time.LocalDate;

/* public class Program {
    public static void main(String[] args) {

// Tạo entity.Department

        Department dep1 = new Department();
        dep1.id = 1;
        dep1.name = "Marketing";
        Department dep2 = new Department();
        dep2.id = 2;
        dep2.name = "Sale";
        Department dep3 = new Department();
        dep3.id = 3;
        dep3.name = "BOD";

// Tạo entity.Position

        Position pos1 = new Position();
        pos1.id = 1;
        pos1.name = PositionName.Dev;
        Position pos2 = new Position();
        pos2.id = 2;
        pos2.name = PositionName.PM;
        Position pos3 = new Position();
        pos3.id = 3;
        pos3.name = PositionName.Scrum_Master;

// Tạo entity.Group

        Group group1 = new Group();
        group1.id = 1;
        group1.name = "Testing System";
        Group group2 = new Group();
        group2.id = 2;
        group2.name = "Development";
        Group group3 = new Group();
        group3.id = 3;
        group3.name = "Sale";

// Tạo entity.Account

        Account acc1 = new Account();
        acc1.setId(1);
        acc1.setEmail("daonq1");
        acc1.setUserName("daonq1");
        acc1.setFullName("Dao Nguyen 1");
        acc1.setDepartment(dep1);
        acc1.setPosition(pos1);
        acc1.setCreateDate(LocalDate.now());
        Group[] groupAcc1 = { group1, group2 };
        acc1.setGroups(groupAcc1);
        Account acc2 = new Account();
        acc2.id = 2;
        acc2.email = "daonq2";
        acc2.userName = "daonq2";
        acc2.fullName = "Dao Nguyen 2";
        acc2.department = dep2;
        acc2.position = pos2;
        acc2.createDate = LocalDate.of(2021, 03, 17);
        acc2.groups = new Group[] { group3, group2 };
        Account acc3 = new Account();
        acc3.id = 3;
        acc3.email = "daonq3";
        acc3.userName = "daonq3";
        acc3.fullName = "Dao Nguyen 3";
        acc3.department = dep3;
        acc3.position = pos3;
        acc3.createDate = LocalDate.now();
        System.out.println("Thông tin các entity.Account trên hệ thống:");
        System.out.println("entity.Account 1: ID : " + acc1.id + " Email: " +

                acc1.email + " UserName: " + acc1.userName

                + " FullName: " + acc1.fullName + " entity.Department: " +

                acc1.department.name + " entity.Position: "

                + acc1.position.name + " entity.Group: "+
                acc1.groups[0].name +" "+ acc1.groups[1].name + "CreateDate: " +
                acc1.createDate);

        System.out.println("entity.Account 2: ID : " + acc2.id + " Email: " +

                acc2.email + " UserName: " + acc2.userName

                + " FullName: " + acc2.fullName + " entity.Department: " +

                acc2.department.name + " entity.Position: "

                + acc2.position.name + " entity.Group: "+
                acc2.groups[0].name +" "+ acc2.groups[1].name + "CreateDate: " +
                acc2.createDate);

        System.out.println("entity.Account 3: ID : " + acc3.id + " Email: " +

                acc3.email + " UserName: " + acc3.userName

                + " FullName: " + acc3.fullName + " entity.Department: " +

                acc3.department.name + " entity.Position: "

                + acc3.position.name + " entity.Group: " + "CreateDate: " +

                acc3.createDate);
    }

}

 */
