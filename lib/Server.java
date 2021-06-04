import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
class Food{
    String name;
    String desc;
    String ready;
    String img;//how to handle :(
    String price;
    String type;
    Food(String description , String name , String price , String type , String ready , String img){
        this.desc = description;
        this.name = name;
        this.price = price;
        this.type = type;
        this.ready = ready;
        this.img = img;
    }
}
class DataBase {
    static ArrayList <RestaurantUser> RestaurantUsers;
    static ArrayList<String> suggestions;
    Socket socket;
    DataInputStream dis ;
    DataOutputStream dos;
    DataBase(Socket socket){
        this.socket = socket;
        try {
             dis = new DataInputStream(socket.getInputStream());
             dos = new DataOutputStream(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public void Save(RestaurantUser restaurantUser , String[] arr , String command) {
        for (int i = 0; i < Integer.valueOf(arr[1]); i+=6) {
            restaurantUser.foods.add(new Food(arr[i+3],arr[i+4],arr[i+5],arr[i+6],arr[i+7],arr[i+8]) );
        }
        FileWriter fw = null;
        BufferedWriter bw = null;
        PrintWriter out = null;
        try {
            if(command.equals("save food")) {
                fw = new FileWriter("Food.txt", true);
                bw = new BufferedWriter(fw);
                out = new PrintWriter(bw);
                out.println(restaurantUser.phoneNum + restaurantUser.foods);
                out.close();
            }
            else if(command.equals("save suggestions")){
                fw = new FileWriter("suggest.txt", true);
                bw = new BufferedWriter(fw);
                out = new PrintWriter(bw);
                out.println(restaurantUser.phoneNum + restaurantUser.foods);
                out.close();
            }
            else if(command.equals("save user")){
                fw = new FileWriter("users.txt", true);
                bw = new BufferedWriter(fw);
                out = new PrintWriter(bw);
                out.println(restaurantUser.phoneNum + restaurantUser.foods);
                out.close();
            }
        } catch (IOException e) {
            //exception handling left as an exercise for the reader
        }
        finally {
            try {
                if (out != null)
                    out.close();
                if (bw != null)
                    bw.close();
            } catch (IOException e) {
                //exception handling left as an exercise for the reader
            }
            try {
                if(fw != null)
                    fw.close();
            } catch (IOException e) {
                //exception handling left as an exercise for the reader
            }
        }

    }

    // Read Users From File
    void ReadUsers(){
        try {
            String USERS = dis.readUTF();
            String[] arr = USERS.split("\n");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }



}
class RestaurantUser {
//this class is just for the restaurant below are the things which are gotten from sign up page
    String name ;
    String phoneNum;
    String password ;
    String foodType;
    String address;
    //foods which are saved in a restaurant
    static ArrayList<Food> foods;
    //keeping the address
    String n;
    String m;
    RestaurantUser(String phoneNum , String password) {
        this.phoneNum = phoneNum;
        this.password = password;
    }
    RestaurantUser(String name , String address , String foodType , String phoneNum , String password){
        this.password  =password;
        this.phoneNum = phoneNum;
        this.address = address;
        this.foodType = foodType;
        this.name = name;
    }
}
class myClientHandler implements Runnable{
    static private RestaurantUser findUser(String username, String password) {
        for (RestaurantUser user:DataBase.RestaurantUsers) {
            if (user.phoneNum.equals(username) && user.password.equals(password))
                return user ;
        }
        return null ;
    }
    Socket s ;
    DataInputStream dis;
    DataOutputStream dos;
    myClientHandler(Socket cs) {
        this.s = cs ;
    }
    @Override
    public void run() {
        try {
            String action = dis.readUTF();
            String[] a = action.split("\n");
            if(a[0].equals("Restaurant")){
                if(a[1].equals("Login")) {
                    System.out.println("Check For Login");
                    String username = a[2];
                    String password = a[3];
                    RestaurantUser user = findUser(username ,password) ;
                    if (user !=null) {
                        System.out.println("Found");
                        dos.writeBoolean(true);
                        dos.flush();
                        dos.writeUTF(user.phoneNum+"\n"+user.password);
                        dos.flush();
                    }
                    else {
                        System.out.println("password or the user name is wrong");
                        dos.writeBoolean(false);
                        dos.flush();

                    }

                }
                else if (a[1].equals("sign up")) {
                    System.out.println("Request For Register");
                    String name = a[2];
                    String address=a[3];
                    String foodType=a[4];
                    String phoneNum=a[5];
                    String password =a[6];
                    RestaurantUser newUser = new RestaurantUser(name , address , foodType , phoneNum , password);
                    DataBase.RestaurantUsers.add(newUser) ;
                    DataBase dataBase = new DataBase(s);
                    dataBase.Save(findUser(a[1] , a[2]) , a ,"save user");
                    dos.writeBoolean(true);
                    dos.flush();
                    dos.writeUTF("");
                    dos.flush();
                }
                else if(a[1].equals("save my foods")){
                    DataBase dataBase = new DataBase(s);
                    dataBase.Save(findUser(a[1] , a[2]) , a ,"save food");
                }
                else if(a[1].equals("read suggestions")){
                    DataBase dataBase = new DataBase(s);
                    dataBase.Save(findUser(a[1] , a[2]) , a ,"save suggestions");
                }
            }

        } catch (IOException ioException) {
            ioException.printStackTrace();
        }

    }

}
public class Server {
    ServerSocket ss;
    {
        try {
            ss = new ServerSocket(321);
            while (true){
                Socket s = ss.accept();
                DataOutputStream dos = new DataOutputStream(s.getOutputStream());
                DataInputStream dis = new DataInputStream(s.getInputStream());
                myClientHandler clientHandler = new myClientHandler(s);
                Thread client = new Thread(clientHandler);
                client.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
