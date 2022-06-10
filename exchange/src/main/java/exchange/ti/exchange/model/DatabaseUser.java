package exchange.ti.exchange.model;

public class DatabaseUser {

        private int id = -1;
        private String login = "";
        private String haslo = "";
        private int uprawnienia = -1;
        boolean isActive = true;


        // -1 niezalogowaany
        // 1 zalogowany
        // 2 adminsitrator


        private String imie = "";
        private String nazwisko = "";

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getLogin() {
            return login;
        }

        public String getHaslo() {
            return haslo;
        }

        public int getUprawnienia() {
            return uprawnienia;
        }

        public String getImie() {
            return imie;
        }

        public String getNazwisko() {
            return nazwisko;
        }

        public boolean isActive() {
            return isActive;
        }

        public void setActive(boolean active) {
            this.isActive = active;
        }

        public void setImie(String imie) {
            this.imie = imie;
        }

        public void setNazwisko(String nazwisko) {
            this.nazwisko = nazwisko;
        }


        public void setLogin(String login) {
            this.login = login;
        }

        public void setHaslo(String haslo) {
            this.haslo = haslo;
        }

        public void setUprawnienia(int uprawnienia) {
            this.uprawnienia = uprawnienia;
        }

    @Override
    public String toString() {
        return "DatabaseUser{" +
                "id=" + id +
                ", login='" + login + '\'' +
                ", haslo='" + haslo + '\'' +
                ", uprawnienia=" + uprawnienia +
                ", isActive=" + isActive +
                ", imie='" + imie + '\'' +
                ", nazwisko='" + nazwisko + '\'' +
                '}';
    }
}

