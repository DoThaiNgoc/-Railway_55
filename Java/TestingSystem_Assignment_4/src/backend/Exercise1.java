package backend;

import entity.Account;

public class Exercise1 {
    public void question2() {
        Account account = new Account();
        Account acc1 = new Account(2,"@email.com","userName","firstName","lastName");

        System.out.println(" email trong account la :" + acc1.getEmail());
    }
}
