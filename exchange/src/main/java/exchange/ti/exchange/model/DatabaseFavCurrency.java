package exchange.ti.exchange.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class DatabaseFavCurrency {

    private int id = -1;
    private int userId = -1;
    private int currencyId = -1;

    public DatabaseFavCurrency() {}
    //    public List<DatabaseFavCurrency> list = new LinkedList<DatabaseFavCurrency>();
//
//
//    public List<DatabaseFavCurrency> getList() {
//        return list;
//    }
//
//    public void setList(List<DatabaseFavCurrency> list) {
//        this.list = list;
//    }
//
//    public void addToList(DatabaseFavCurrency object){
//        this.list.add(object);
//    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public double getCurrencyId() {
        return currencyId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setCurrencyId(int currencyId) {
        this.currencyId = currencyId;
    }

    @Override
    public String toString() {
        return "DatabaseFavCurrency{" +
                "id=" + id +
                ", userId=" + userId +
                ", currencyId=" + currencyId +
                '}';
    }
}
