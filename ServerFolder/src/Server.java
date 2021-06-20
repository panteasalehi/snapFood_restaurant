import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

///
class DataBase {
    static ArrayList<RestaurantUser> RestaurantUsers = new ArrayList<>();
    static ArrayList<String> suggestions;
    Socket socket;
    DataInputStream dis;
    DataOutputStream dos;

    DataBase(Socket socket) {
        this.socket = socket;
        try {
            dis = new DataInputStream(socket.getInputStream());
            dos = new DataOutputStream(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    static String ReadFile(){
        FileReader fr = null;
        StringBuilder sb = new StringBuilder();
        try {
             fr = new FileReader("users.txt");
             int i ;
             sb.append("\n");
            while (( i= fr.read()) != -1)
                sb.append((char) i);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static void Save(String[] arr, String command) {
        FileWriter fw = null;
        BufferedWriter bw = null;
        PrintWriter out = null;
        try {
            if (command.equals("save food")) {
                fw = new FileWriter("Food.txt", true);
                bw = new BufferedWriter(fw);
                bw.write(arr[5]+"\n"+arr[4]+"\n"+arr[3]+"\n"+arr[2]+"\n"+arr[7]);
                out = new PrintWriter(bw);
                //  out.println(restaurantUser.phoneNum + restaurantUser.foods);
                out.close();
            } else if (command.equals("save suggestions")) {
                fw = new FileWriter("suggest.txt", true);
                bw = new BufferedWriter(fw);
                out = new PrintWriter(bw);
                //  out.println(restaurantUser.phoneNum + restaurantUser.foods);
                out.close();
            } else if (command.equals("save user")) {
                fw = new FileWriter("users.txt", true);
                bw = new BufferedWriter(fw);
                bw.write(arr[2]+"\n"+arr[3]+"\n"+arr[4]+"\n"+arr[7]+"\n"+arr[8]+"\n");
                //out.println(restaurantUser.phoneNum + restaurantUser.foods);
            }
            else if(command.equals("save code")){
                fw = new FileWriter(arr[2]+".txt", true);
                bw = new BufferedWriter(fw);
                bw.write(arr[4]+"\n");
            }
        } catch (IOException e) {
            //exception handling left as an exercise for the reader
        } finally {
            try {
                if (out != null)
                    out.close();
                if (bw != null)
                    bw.close();
            } catch (IOException e) {
                //exception handling left as an exercise for the reader
                // :/
            }
            try {
                if (fw != null)
                    fw.close();
            } catch (IOException e) {
                //exception handling left as an exercise for the reader
                // :/
            }
        }

    }


}
class Food{
    String name;
    String price;
    String description;
    String ready;
    Food(String name, String price, String description, String ready){
        this.name=name;
        this.price = price;
        this.description = description;
        this.ready = ready;
    }
}
class RestaurantUser {
    //this class is just for the restaurant below are the things which are gotten from sign up page
    String name;
    String phoneNum;
    String password;
    String foodType;
    String address;
    ArrayList codes = new ArrayList();
    //foods which are saved in a restaurant
     ArrayList<Food> foods = new ArrayList<>();
     Map<Integer,String> ans = new ConcurrentHashMap<>();
    //keeping the address
    String longitude;
    String latitude;

    RestaurantUser(String name, String address, String foodType, String phoneNum, String password) {
        this.password = password;
        this.phoneNum = phoneNum;
        this.address = address;
        this.foodType = foodType;
        this.name = name;
    }
}
    class ClientHandler implements Runnable {
        Socket s;
        DataOutputStream dos;
        DataInputStream dis;
        RestaurantUser restaurantUser;
        ClientHandler(Socket socket) {
            s = socket;
            try {
                dis = new DataInputStream(s.getInputStream());
                dos = new DataOutputStream(s.getOutputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        RestaurantUser findUser(String username, String password) {
            if(DataBase.RestaurantUsers.size()==0){
                try {
                    FileReader fileReader = new FileReader("users.txt");
                    int i;
                    String str = "";
                    while ((i=fileReader.read()) != -1)
                        str += ((char)i);
                    String[] array = str.split("\n");
                    for (int j = 0; j < array.length; j++) {
                        RestaurantUser newUser = new RestaurantUser(array[0], array[1], array[2], array[3], array[4]);
                        DataBase.RestaurantUsers.add(newUser);
                    }

                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            for (RestaurantUser user : DataBase.RestaurantUsers) {
                if (user.phoneNum.equals(username) && user.password.equals(password))
                    return user;
            }
            return null;
        }

        @Override
        public void run() {
            try {
                String read = dis.readLine();
                String[] command = read.split("the String is");
                System.out.println(read);
                if(command[1].contains("start")){
                    System.out.println("hihihii");
                    String s = DataBase.ReadFile();
                    System.out.println(s);
                   dos.writeUTF(s);
                   dos.flush();
                }
                if(command[1].contains("suggestions")){
                    String ans = command[2];
                    int num = Integer.valueOf(command[3]);
                    restaurantUser = findUser(command[4],command[5]);
                    restaurantUser.ans.put(num,ans);
                }
                if(command[1].contains("add code")){
                    restaurantUser = findUser(command[2],command[3]);
                    restaurantUser.codes.add(command[4]);
                    DataBase.Save(command,"save code");
                }
                if(command[1].contains("adding location")){
                    restaurantUser = findUser(command[4],command[5]);
                    restaurantUser.longitude = command[2];
                    restaurantUser.latitude = command[3];
                }
                if(command[1].contains("add food")){
                    System.out.println("request for adding food");
                    String foodName = command[2];
                    String price = command[3];
                    String description = command[4];
                    restaurantUser = findUser(command[5],command[6]);
                    String ready = command[7];
                    restaurantUser.foods.add(new Food(foodName,price,description,ready));
                    DataBase.Save(command,"save food");
                }
                if (command[1].contains("signup")) {
                    System.out.println("Request For sign up");
                    String name = command[2];
                    String address = command[3];
                    String foodType;
                    if(command[4].equals("true")){
                        foodType = "fastfood";
                    }
                    else if(command[5].equals("true")){
                        foodType = "seafood";
                    }
                    else if(command[6].equals("true")){
                        foodType = "home";
                    }
                    else foodType = null;
                    command[4]=foodType;
                    String phoneNum = command[7];
                    String password = command[8];
                    //System.out.println("name" + name + "address" + address + "foodType" + foodType + "phoneNum" + phoneNum + "password" + password);
                    RestaurantUser newUser = new RestaurantUser(name, address, foodType, phoneNum, password);
                    DataBase.RestaurantUsers.add(newUser);
                    DataBase.Save(command , "save user");
                    restaurantUser = newUser;
                    dos.writeUTF("ok");
                    dos.flush();
                }
                if (command[1].contains("login")) {
                    System.out.println("request for log in");
                    String phoneNum = command[2];
                    String pass = command[3];
                    System.out.println("the phone " + phoneNum + " the pass " + pass);
               try{
                   if(findUser(phoneNum ,pass)==null) {
                       dos.writeUTF("no such a user exists");
                   }
                   else{
                       dos.writeUTF("welcome");
                       restaurantUser = findUser(phoneNum,pass);
                   }

               }catch (NullPointerException e){
                   e.printStackTrace();
                   dos.writeUTF("no such a user exists");
                   System.out.println("3");
               }


                }

            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

public class Server{
    public static void main(String[] args) {
        try {
            ServerSocket ss = new ServerSocket(1122);
            while (true){
                Socket s = ss.accept();
                System.out.println("client connected");
                Thread client = new Thread(new ClientHandler(s));
                client.start();
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}