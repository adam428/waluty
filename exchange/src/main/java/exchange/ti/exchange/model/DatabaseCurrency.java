package exchange.ti.exchange.model;

public class DatabaseCurrency {

    private int id = -1;
    private String nazwa = "";

    public int getId() {
        return id;
    }

    public String getNazwa() {
        return nazwa;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNazwa(String nazwa) {
        this.nazwa = nazwa;
    }

    @Override
    public String toString() {
        return "DatabaseCurrency{" +
                "id=" + id +
                ", nazwa='" + nazwa + '\'' +
                '}';
    }
}
